output "synthetics_script_monitor" {
  value = {
    id   = newrelic_synthetics_script_monitor.this.id
    name = newrelic_synthetics_script_monitor.this.name
    tags = { for t in newrelic_synthetics_script_monitor.this.tag : t.key => t.values }
  }
}

output "synthetics_alert_condition" {
  value = try({
    id          = newrelic_synthetics_alert_condition.this[0].id
    policy_id   = newrelic_synthetics_alert_condition.this[0].policy_id
    monitor_id  = newrelic_synthetics_alert_condition.this[0].monitor_id
    runbook_url = newrelic_synthetics_alert_condition.this[0].runbook_url
  }, null)
}
