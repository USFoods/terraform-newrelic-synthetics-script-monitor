terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~>3.14.0"
    }
  }
}

resource "newrelic_alert_policy" "main" {
  account_id          = var.account_id
  name                = "Synthetics Testing Policy"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

module "main" {
  source = "../.."

  account_id        = var.account_id
  private_locations = [var.location_name]

  name    = "Synthetics Testing Monitor"
  enabled = var.enabled
  period  = "EVERY_5_MINUTES"

  script = file("${path.module}/script.js")

  condition = {
    policy_id = newrelic_alert_policy.sre_nr_data_ingest.id
  }
}
