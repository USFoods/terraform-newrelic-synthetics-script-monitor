package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestScriptApiPrivateConfiguration(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/script_api_private",
		Vars: map[string]interface{}{
			"account_id": os.Getenv("NEW_RELIC_ACCOUNT_ID"),
			"enabled":    false,
		},
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Get module output for account id, enabled, name, type, script, private locations, and tags
	outputAccountId := terraform.Output(t, terraformOptions, "account_id")
	outputEnabled := terraform.Output(t, terraformOptions, "enabled")
	outputName := terraform.Output(t, terraformOptions, "name")
	outputType := terraform.Output(t, terraformOptions, "type")
	outputScript := terraform.Output(t, terraformOptions, "script")
	outputPrivateLocations := terraform.Output(t, terraformOptions, "private_locations")
	outputTags := terraform.Output(t, terraformOptions, "tags")

	// Assert account id is set to test account id
	assert.Equal(t, os.Getenv("NEW_RELIC_ACCOUNT_ID"), outputAccountId)
	// Assert enabled is set to false
	assert.Equal(t, "false", outputEnabled)
	// Assert name is set to Script API Private Synthetic Monitor
	assert.Equal(t, "Script API Private Synthetic Monitor", outputName)
	// Assert type is set to SCRIPT_API
	assert.Equal(t, "SCRIPT_API", outputType)
	// Assert script matches the script in the terraform configuration
	assert.Equal(t, "console.log('Example script is working...')", outputScript)
	// Assert private locations is set to TF Exmaple
	assert.Equal(t, "[TF Example]", outputPrivateLocations)
	// Assert tags are set to Origin=Terraform, App.Id=1234, App.Code=EXAMPLE
	assert.Equal(t, "map[App.Code:EXAMPLE App.Id:1234 Origin:Terraform]", outputTags)
}
