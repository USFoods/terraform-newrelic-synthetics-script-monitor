package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestScriptBrowserConditionConfiguration(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/script_browser_condition",
		Vars: map[string]interface{}{
			"account_id": os.Getenv("NEW_RELIC_ACCOUNT_ID"),
			"enabled":    false,
		},
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Get all output
	outputAll := terraform.OutputAll(t, terraformOptions)

	// We actuall want a map of strings, not interfaces
	output := map[string]string{}
	// Would be nice if this output was built into Terratest
	for k, v := range outputAll {
		output[k] = fmt.Sprintf("%v", v)
	}

	assert.Equal(t, "Script Browser Condition Policy", output["policy_name"])
	assert.Equal(t, output["policy_id"], output["condition_policy_id"])

	assert.Equal(t, "Script Browser Condition Synthetic Monitor", output["module_name"])
	assert.Equal(t, "SCRIPT_BROWSER", output["module_type"])
	assert.Equal(t, fmt.Sprint([]string{"US_WEST_1"}), output["module_public_locations"])

	assert.Equal(t, "Script Browser Condition Synthetic Monitor", output["condition_name"])
	assert.Equal(t, "NRQL Alert Condition for Monitor: Script Browser Condition Synthetic Monitor", output["condition_description"])
	assert.Equal(t, "900", output["condition_critical_threshold_duration"])

	expected_tags := map[string]string{
		"Origin":   "Terraform",
		"App.Id":   "1234",
		"App.Code": "EXAMPLE",
	}

	assert.Equal(t, fmt.Sprint(expected_tags), output["module_tags"])
	assert.Equal(t, fmt.Sprint(expected_tags), output["condition_tags"])
}
