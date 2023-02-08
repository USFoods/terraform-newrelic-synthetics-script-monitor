data "newrelic_synthetics_private_location" "private_location" {
  for_each = toset(coalesce(var.private_locations, []))

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
    key    = "Origin"
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

module "nrql_alert_condition" {
  source  = "usfoods/nrql-alert-condition/newrelic"
  version = "1.0.1"

  count = var.condition == null ? 0 : 1

  account_id  = var.account_id
  policy_id   = var.condition.policy_id
  enabled     = var.condition.enabled && var.enabled
  name        = coalesce(var.condition.name, var.name)
  description = coalesce(var.condition.description, "Monitor failed on ${newrelic_synthetics_script_monitor.this.name}")
  runbook_url = var.condition.runbook_url

  query = "SELECT count(*) FROM SyntheticCheck WHERE entityGuid = '${newrelic_synthetics_script_monitor.this.id}' AND result = 'FAILED'"

  tags = merge(var.condition.tags, var.tags)

  critical = {
    operator            = "ABOVE"
    threshold           = 0
    threshold_duration  = 60
    threshold_occurence = "AT_LEAST_ONCE"
  }
}
