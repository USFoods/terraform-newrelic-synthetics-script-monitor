terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~>3.14"
    }
  }
}

provider "newrelic" {
  account_id = var.account_id
}

module "main" {
  source = "../.."

  account_id = var.account_id
  enabled    = var.enabled
  name       = "Script Browser Public Synthetic Monitor"
  type       = "SCRIPT_BROWSER"

  script = "$browser.get('https://one.newrelic.com')"

  script_language = "JAVASCRIPT"
  runtime_type    = "CHROME_BROWSER"
  runtime_version = "100"

  public_locations = ["US_WEST_1"]

  tags = {
    "App.Id"   = ["1234"]
    "App.Code" = ["EXAMPLE"]
  }
}
