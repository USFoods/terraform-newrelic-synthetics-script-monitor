output "id" {
  description = "The ID of the Synthetics script monitor"
  value       = module.main.id
}

output "account_id" {
  description = "The id of the account where where the synthetic monitor lives"
  value       = module.main.account_id
}

output "enabled" {
  description = "The run state of the monitor"
  value       = module.main.enabled
}

output "name" {
  description = "The name for the monitor"
  value       = module.main.name
}

output "type" {
  description = "The plaintext representing the monitor script"
  value       = module.main.type
}

output "public_locations" {
  description = "The public locations the monitor is running from"
  value       = module.main.public_locations
}

output "private_locations" {
  description = "The private locations the monitor is running from"
  value       = module.main.private_locations
}

output "private_location_ids" {
  description = "The private locations the monitor is running from"
  value       = module.main.private_location_ids
}

output "period" {
  description = "The interval at which this monitor is run"
  value       = module.main.period
}

output "script" {
  description = "The script that the monitor runs"
  value       = module.main.script
}

output "runtime_type" {
  description = "The runtime that the monitor uses to run jobs"
  value       = module.main.runtime_type
}

output "runtime_version" {
  description = "The specific version of the runtime type selected"
  value       = module.main.runtime_version
}

output "script_language" {
  description = "The programing language that executes the script"
  value       = module.main.script_language
}

output "tags" {
  description = "The tags associated with the synthetics script monitor"
  value       = module.main.tags
}

output "enable_screenshot" {
  description = "Capture a screenshot during job execution"
  value       = module.main.enable_screenshot
}
