output "id" {
  description = "The ID of the Synthetics script monitor"
  value       = newrelic_synthetics_script_monitor.this.id
}

output "account_id" {
  description = "The id of the account where where the synthetic monitor lives"
  value       = tostring(newrelic_synthetics_script_monitor.this.account_id)
}

output "enabled" {
  description = "The run state of the monitor"
  value       = newrelic_synthetics_script_monitor.this.status == "ENABLED" ? true : false
}

output "name" {
  description = "The name for the monitor"
  value       = newrelic_synthetics_script_monitor.this.name
}

output "type" {
  description = "The plaintext representing the monitor script"
  value       = newrelic_synthetics_script_monitor.this.type
}

output "public_locations" {
  description = "The public locations the monitor is running from"
  value       = newrelic_synthetics_script_monitor.this.locations_public
}

output "private_locations" {
  description = "The private locations the monitor is running from"
  value       = var.private_locations
}

output "period" {
  description = "The interval at which this monitor is run"
  value       = newrelic_synthetics_script_monitor.this.period
}

output "script" {
  description = "The script that the monitor runs"
  value       = newrelic_synthetics_script_monitor.this.script
}

output "runtime_type" {
  description = "The runtime that the monitor uses to run jobs"
  value       = newrelic_synthetics_script_monitor.this.runtime_type
}

output "runtime_version" {
  description = "The specific version of the runtime type selected"
  value       = newrelic_synthetics_script_monitor.this.runtime_type_version
}

output "script_language" {
  description = "The programing language that executes the script"
  value       = newrelic_synthetics_script_monitor.this.script_language
}

output "tags" {
  description = "The tags associated with the synthetics script monitor"
  value       = { for t in newrelic_entity_tags.this.tag : t.key => join(",", toset(t.values)) }
}

output "enable_screenshot" {
  description = "Capture a screenshot during job execution"
  value       = newrelic_synthetics_script_monitor.this.enable_screenshot_on_failure_and_script
}

output "condition_policy_id" {
  description = "The ID of the policy where this condition is used"
  value       = try(module.nrql_alert_condition[0].policy_id, "")
}

output "condition_enabled" {
  description = "Whether the alert condition is enabled"
  value       = try(module.nrql_alert_condition[0].enabled, "")
}

output "condition_name" {
  description = "The title of the condition"
  value       = try(module.nrql_alert_condition[0].name, "")
}

output "condition_description" {
  description = "The description of the NRQL alert condition"
  value       = try(module.nrql_alert_condition[0].description, "")
}

output "condition_runbook_url" {
  description = "Runbook URL to display in notifications"
  value       = try(module.nrql_alert_condition[0].runbook_url, "")
}

output "condition_tags" {
  description = "The tags associated with the alert condition"
  value       = try(module.nrql_alert_condition[0].tags, "")
}
