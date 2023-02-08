# Terraform New Relic Synthetics Script Monitor Module

This module handles opinionated New Relic Synthetics Script Monitor creation and configuration.

## Compatability

This module is meant for use with Terraform 1.0+ and tested using Terraform 1.3+.
If you find incompatibilities using Terraform `>=1.0`, please open an issue.

## Usage

There are multiple examples included in the [examples](https://github.com/usfoods/terraform-newrelic-nrql-alert-condition/tree/master/examples) folder but simple usage is as follows:

```hcl
provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "main" {
  name                = "Script API Condition Policy"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

module "main" {
  source = "usfoods/synthetics-script-monitor/newrelic"

  account_id = var.account_id
  enabled    = var.enabled
  name       = "Script API Condition Synthetic Monitor"

  script = "console.log('Example script is working...')"

  script_language = "JAVASCRIPT"
  runtime_type    = "NODE_API"
  runtime_version = "16.10"

  public_locations = ["US_WEST_1"]

  condition = {
    policy_id = newrelic_alert_policy.main.id
  }

  tags = {
    "App.Id"   = ["1234"]
    "App.Code" = ["EXAMPLE"]
  }
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 3.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 3.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nrql_alert_condition"></a> [nrql\_alert\_condition](#module\_nrql\_alert\_condition) | usfoods/nrql-alert-condition/newrelic | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [newrelic_synthetics_script_monitor.this](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/synthetics_script_monitor) | resource |
| [newrelic_synthetics_private_location.private_location](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/data-sources/synthetics_private_location) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The id of the account where where the synthetic monitor lives | `string` | n/a | yes |
| <a name="input_condition"></a> [condition](#input\_condition) | Creates a NRQL Alert Condition for the monitor | <pre>object({<br>    policy_id   = string<br>    enabled     = optional(bool, true)<br>    name        = optional(string, "")<br>    description = optional(string, "")<br>    runbook_url = optional(string, "")<br>    tags        = optional(map(list(string)), {})<br>  })</pre> | `null` | no |
| <a name="input_enable_screenshot"></a> [enable\_screenshot](#input\_enable\_screenshot) | Capture a screenshot during job execution | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | The run state of the monitor | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the monitor | `string` | n/a | yes |
| <a name="input_period"></a> [period](#input\_period) | The interval at which this monitor should run | `string` | `"EVERY_15_MINUTES"` | no |
| <a name="input_private_locations"></a> [private\_locations](#input\_private\_locations) | The private locations the monitor will run from | `list(string)` | `null` | no |
| <a name="input_public_locations"></a> [public\_locations](#input\_public\_locations) | The public locations the monitor will run from | `list(string)` | `null` | no |
| <a name="input_runtime_type"></a> [runtime\_type](#input\_runtime\_type) | The runtime that the monitor will use to run jobs | `string` | `""` | no |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | The specific version of the runtime type selected | `string` | `""` | no |
| <a name="input_script"></a> [script](#input\_script) | The script that the monitor runs | `string` | n/a | yes |
| <a name="input_script_language"></a> [script\_language](#input\_script\_language) | The programing language that should execute the script | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags that will be associated with the monitor | `map(list(string))` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The plaintext representing the monitor script | `string` | `"SCRIPT_API"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_condition_description"></a> [condition\_description](#output\_condition\_description) | The description of the NRQL alert condition |
| <a name="output_condition_enabled"></a> [condition\_enabled](#output\_condition\_enabled) | Whether the alert condition is enabled |
| <a name="output_condition_name"></a> [condition\_name](#output\_condition\_name) | The title of the condition |
| <a name="output_condition_policy_id"></a> [condition\_policy\_id](#output\_condition\_policy\_id) | The ID of the policy where this condition is used |
| <a name="output_condition_runbook_url"></a> [condition\_runbook\_url](#output\_condition\_runbook\_url) | Runbook URL to display in notifications |
| <a name="output_condition_tags"></a> [condition\_tags](#output\_condition\_tags) | The tags associated with the alert condition |
| <a name="output_enable_screenshot"></a> [enable\_screenshot](#output\_enable\_screenshot) | Capture a screenshot during job execution |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Synthetics script monitor |
| <a name="output_name"></a> [name](#output\_name) | The name for the monitor |
| <a name="output_period"></a> [period](#output\_period) | The interval at which this monitor is run |
| <a name="output_private_locations"></a> [private\_locations](#output\_private\_locations) | The private locations the monitor is running from |
| <a name="output_public_locations"></a> [public\_locations](#output\_public\_locations) | The public locations the monitor is running from |
| <a name="output_runtime_type"></a> [runtime\_type](#output\_runtime\_type) | The runtime that the monitor uses to run jobs |
| <a name="output_runtime_version"></a> [runtime\_version](#output\_runtime\_version) | The specific version of the runtime type selected |
| <a name="output_script_language"></a> [script\_language](#output\_script\_language) | The programing language that executes the script |
| <a name="output_status"></a> [status](#output\_status) | The run state of the monitor |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags associated with the synthetics script monitor |
| <a name="output_type"></a> [type](#output\_type) | The plaintext representing the monitor script |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
