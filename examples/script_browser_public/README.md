# Script API Public

Configuration in this directory creates a new synthetic script monitor of type SCRIPT_BROWSER which runs in a public location.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >=3.14 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The New Relic account ID of the account you wish to create the condition | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to enable the synthetics script monitor | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | The id of the account where where the synthetic monitor lives |
| <a name="output_enable_screenshot"></a> [enable\_screenshot](#output\_enable\_screenshot) | Capture a screenshot during job execution |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | The run state of the monitor |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Synthetics script monitor |
| <a name="output_name"></a> [name](#output\_name) | The name for the monitor |
| <a name="output_period"></a> [period](#output\_period) | The interval at which this monitor is run |
| <a name="output_private_locations"></a> [private\_locations](#output\_private\_locations) | The private locations the monitor is running from |
| <a name="output_public_locations"></a> [public\_locations](#output\_public\_locations) | The public locations the monitor is running from |
| <a name="output_runtime_type"></a> [runtime\_type](#output\_runtime\_type) | The runtime that the monitor uses to run jobs |
| <a name="output_runtime_version"></a> [runtime\_version](#output\_runtime\_version) | The specific version of the runtime type selected |
| <a name="output_script"></a> [script](#output\_script) | The script that the monitor runs |
| <a name="output_script_language"></a> [script\_language](#output\_script\_language) | The programing language that executes the script |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags associated with the synthetics script monitor |
| <a name="output_type"></a> [type](#output\_type) | The plaintext representing the monitor script |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
