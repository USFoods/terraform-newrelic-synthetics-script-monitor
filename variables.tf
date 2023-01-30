variable "account_id" {
  description = "The id of the account where where the synthetic monitor lives"
  type        = string
}

variable "private_locations" {
  default     = []
  description = "The names of the synthetics private locations"
  type        = list(string)
}

variable "public_locations" {
  default     = null
  description = "value"
  type        = list(string)
}

variable "enabled" {
  default     = false
  description = "The run state of the monitor"
  type        = bool
}

variable "name" {
  description = "The name for the monitor"
  type        = string
}

variable "type" {
  default     = "SCRIPT_API"
  description = "value"
  type        = string
}

variable "period" {
  default     = "EVERY_15_MINUTES"
  description = "The interval at which this monitor should run"
  type        = string
}

variable "enable_screenshot" {
  default     = false
  description = "Capture a screenshot during job execution"
  type        = bool
}

variable "script" {
  description = "The script that the monitor runs"
  type        = string
}

variable "script_language" {
  default     = ""
  description = "The programing language that should execute the script"
  type        = string
}

variable "runtime_type" {
  default     = ""
  description = "The runtime that the monitor will use to run jobs"
  type        = string
}

variable "runtime_version" {
  default     = ""
  description = "The specific version of the runtime type selected"
  type        = string
}

variable "tags" {
  default     = {}
  description = "The tags that will be associated with the monitor"
  type        = map(list(string))
}

variable "condition" {
  default = null
  type = object({
    policy_id   = string
    name        = optional(string, "")
    runbook_url = optional(string, "")
  })
}
