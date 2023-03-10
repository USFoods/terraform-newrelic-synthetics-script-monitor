terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~>3.13.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "newrelic" {
  account_id = var.account_id
}

provider "time" {
  # Configuration options
}

resource "newrelic_synthetics_private_location" "main" {
  description = "A private location for an example"
  name        = "TF Example"
}

/* 
 * In a production scenario a private location would be created
 * well in advance of any synthetic monitors being run on it, so
 * this is just a work around to ensure the location is available
 * when the module attempts to fetch it.
 */
resource "time_sleep" "wait_10_seconds" {
  depends_on = [newrelic_synthetics_private_location.main]

  create_duration = "10s"
}

module "main" {
  source = "../.."

  depends_on = [time_sleep.wait_10_seconds]

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
