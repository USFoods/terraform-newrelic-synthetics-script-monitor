provider "newrelic" {
  account_id = var.account_id
}

# Unfortunately required for test assertion as currently run block
# output from the setup_configuration run block can't be captured
# https://github.com/hashicorp/terraform/pull/34118

# tflint-ignore: terraform_unused_declarations
data "newrelic_synthetics_private_location" "setup" {
  account_id = var.account_id
  name       = "TF Example"
}

module "main" {
  source = "../.."

  account_id = var.account_id
  enabled    = var.enabled
  name       = "Script API Private Synthetic Monitor"

  script = "console.log('Example script is working...')"

  script_language = "JAVASCRIPT"
  runtime_type    = "NODE_API"
  runtime_version = "16.10"

  private_locations = ["TF Example"]

  tags = {
    "App.Id"   = ["1234"]
    "App.Code" = ["EXAMPLE"]
  }
}
