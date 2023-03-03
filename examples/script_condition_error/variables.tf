variable "account_id" {
  default     = "399096"
  description = "Determines the New Relic account where resources are created"
  type        = string
}

variable "location_name" {
  default     = "USFOODS Prod"
  description = "Determines the private synthetic location where scripts are run"
  type        = string
}

variable "enabled" {
  default     = true
  description = "Determines if the resources are enabled"
  type        = bool
}
