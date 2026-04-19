variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day22-costmgmt"

  validation {
    condition     = can(regex("^rg-", var.resource_group_name))
    error_message = "Resource group name must start with 'rg-'."
  }
}

variable "location" {
  type        = string
  description = "Azure region for the resource group"
  default     = "canadacentral"
}

variable "monthly_budget_amount" {
  type        = number
  description = "Monthly budget threshold in USD"
  default     = 100
}

variable "budget_alert_threshold_percentage" {
  type        = number
  description = "Percentage of budget to trigger alert (e.g., 80 for 80%)"
  default     = 80

  validation {
    condition     = var.budget_alert_threshold_percentage > 0 && var.budget_alert_threshold_percentage <= 100
    error_message = "Threshold percentage must be between 1 and 100."
  }
}

variable "alert_email_addresses" {
  type        = list(string)
  description = "Email addresses to receive budget alerts"
  default     = ["admin@example.com"]
}
