data "newrelic_synthetics_private_location" "private_location" {
  for_each = toset(var.private_locations)

  account_id = var.account_id
  name       = each.value
}

resource "newrelic_synthetics_script_monitor" "this" {
  account_id = var.account_id
  status     = var.enabled ? "ENABLED" : "DISABLED"
  name       = var.name
  type       = var.type

  dynamic "location_private" {
    for_each = data.newrelic_synthetics_private_location.private_location
    content {
      guid = location_private.value.id
    }
  }

  locations_public = toset(var.public_locations)

  period = var.period
  script = var.script

  script_language      = var.script_language
  runtime_type         = var.runtime_type
  runtime_type_version = var.runtime_version

  enable_screenshot_on_failure_and_script = var.enable_screenshot

  tag {
    key    = "ORIGIN"
    values = ["Terraform"]
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key    = tag.key
      values = tag.value
    }
  }
}

resource "newrelic_synthetics_alert_condition" "this" {
  count = var.condition == null ? 0 : 1

  policy_id = var.condition.policy_id

  name        = coalesce(var.condition.name, var.name)
  enabled     = var.enabled
  monitor_id  = newrelic_synthetics_script_monitor.this.id
  runbook_url = var.condition.runbook_url
}
