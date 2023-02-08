output "module_id" {
  description = "The ID of the Synthetics script monitor"
  value       = module.main.id
}

output "module_status" {
  description = "The run state of the monitor"
  value       = module.main.status
}

output "module_name" {
  description = "The name for the monitor"
  value       = module.main.name
}

output "module_type" {
  description = "The plaintext representing the monitor script"
  value       = module.main.type
}

output "module_private_locations" {
  description = "The private locations the monitor is running from"
  value       = module.main.private_locations
}

output "module_public_locations" {
  description = "The public locations the monitor is running from"
  value       = module.main.public_locations
}

output "module_period" {
  description = "The interval at which this monitor is run"
  value       = module.main.period
}

output "module_script_language" {
  description = "The programing language that executes the script"
  value       = module.main.script_language
}

output "module_runtime_type" {
  description = "The runtime that the monitor uses to run jobs"
  value       = module.main.runtime_type
}

output "module_runtime_version" {
  description = "The specific version of the runtime type selected"
  value       = module.main.runtime_version
}

output "module_enable_screenshot" {
  description = "Capture a screenshot during job execution"
  value       = module.main.enable_screenshot
}

output "module_tags" {
  description = "The tags associated with the synthetics script monitor"
  value       = module.main.tags
}
