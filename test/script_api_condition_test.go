package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestScriptApiConditionConfiguration(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/script_api_condition",
		Vars: map[string]interface{}{
			"account_id": os.Getenv("NEW_RELIC_ACCOUNT_ID"),
			"enabled":    false,
		},
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Get output for policy id, name, and condition policy id
	outputPolicyId := terraform.Output(t, terraformOptions, "policy_id")
	outputPolicyName := terraform.Output(t, terraformOptions, "policy_name")
	outputConditionPolicyId := terraform.Output(t, terraformOptions, "condition_policy_id")

	// Get output for module account id, enabled, name, type, script, public locations, and tags
	outputAccountId := terraform.Output(t, terraformOptions, "account_id")
	outputEnabled := terraform.Output(t, terraformOptions, "enabled")
	outputName := terraform.Output(t, terraformOptions, "name")
	outputType := terraform.Output(t, terraformOptions, "type")
	outputScript := terraform.Output(t, terraformOptions, "script")
	outputPublicLocations := terraform.Output(t, terraformOptions, "public_locations")
	outputTags := terraform.Output(t, terraformOptions, "tags")

	// Get output for condition name, enabled, description, runbook url, and tags
	outputConditionName := terraform.Output(t, terraformOptions, "condition_name")
	outputConditionEnabled := terraform.Output(t, terraformOptions, "condition_enabled")
	outputConditionDescription := terraform.Output(t, terraformOptions, "condition_description")
	outputConditionRunbookUrl := terraform.Output(t, terraformOptions, "condition_runbook_url")
	outputConditionTags := terraform.Output(t, terraformOptions, "condition_tags")

	// Assert policy name is Script API Condition Policy
	assert.Equal(t, "Script API Condition Policy", outputPolicyName)
	// Assert condition policy id matches policy id
	assert.Equal(t, outputPolicyId, outputConditionPolicyId)
	// Assert account id is set to test account id
	assert.Equal(t, os.Getenv("NEW_RELIC_ACCOUNT_ID"), outputAccountId)
	// Assert enabled is set to false
	assert.Equal(t, "false", outputEnabled)
	// Assert name is set to Script API Condition
	assert.Equal(t, "Script API Condition Synthetic Monitor", outputName)
	// Assert type is set to SCRIPT_API
	assert.Equal(t, "SCRIPT_API", outputType)
	// Assert script is "console.log('Example script is working...')"
	assert.Equal(t, "console.log('Example script is working...')", outputScript)
	// Assert public locations is set to ["US_WEST_1"]
	assert.Equal(t, "[US_WEST_1]", outputPublicLocations)
	// Assert tags are set to map[Origin:Terraform App.Id:1234 App.Code:EXAMPLE]
	assert.Equal(t, "map[App.Code:EXAMPLE App.Id:1234 Origin:Terraform]", outputTags)
	// Assert condition name is set to Script API Condition
	assert.Equal(t, "Script API Condition Synthetic Monitor", outputConditionName)
	// Assert condition enabled is set to false
	assert.Equal(t, "false", outputConditionEnabled)
	// Assert condition description is set to NRQL Alert Condition for Monitor: Script API Condition
	assert.Equal(t, "NRQL Alert Condition for Monitor: Script API Condition Synthetic Monitor", outputConditionDescription)
	// Assert condition runbook url is empty
	assert.Equal(t, "", outputConditionRunbookUrl)
	// Assert condition tags are set to map[Origin:Terraform App.Id:1234 App.Code:EXAMPLE]
	assert.Equal(t, "map[App.Code:EXAMPLE App.Id:1234 Origin:Terraform]", outputConditionTags)
}
