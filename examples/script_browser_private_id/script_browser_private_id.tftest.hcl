run "setup_configuration" {
  command = apply

  variables {
    account_id = var.account_id
  }

  module {
    source = "./testing/setup"
  }
}

run "monitor_configuration" {
  command = apply

  assert {
    condition     = output.main.enabled == false
    error_message = "monitor enabled did not match expected"
  }

  assert {
    condition     = output.main.name == "Script Browser Private Synthetic Monitor"
    error_message = "monitor name did not match expected"
  }

  assert {
    condition     = output.main.type == "SCRIPT_BROWSER"
    error_message = "monitor type did not match expected"
  }

  assert {
    condition     = output.main.private_locations == toset([data.newrelic_synthetics_private_location.setup.id])
    error_message = "monitor private locations did not match expected"
  }

  assert {
    condition     = output.main.period == "EVERY_15_MINUTES"
    error_message = "monitor period did not match expected"
  }

  assert {
    condition     = output.main.script_language == "JAVASCRIPT"
    error_message = "monitor script language did not match expected"
  }

  assert {
    condition     = output.main.runtime_type == "CHROME_BROWSER"
    error_message = "monitor runtime type did not match expected"
  }

  assert {
    condition     = output.main.runtime_version == "100"
    error_message = "monitor runtime version did not match expected"
  }

  assert {
    condition     = output.main.enable_screenshot == false
    error_message = "monitor enable screenshot did not match expected"
  }

  assert {
    condition     = output.main.tags == { "Origin" : "Terraform", "App.Id" : "1234", "App.Code" : "EXAMPLE" }
    error_message = "monitor enable screenshot did not match expected"
  }
}
