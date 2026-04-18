variable "resource_group_name" {
  description = "Name of the resource group for observability components"
  type        = string
  default     = "rg-day20-monitor"
}

variable "location" {
  description = "Azure region for Log Analytics resources"
  type        = string
  default     = "eastus"
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
  default     = "lawday20monitor"
}

variable "log_retention_in_days" {
  description = "Retention period for Log Analytics data"
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_in_days >= 30 && var.log_retention_in_days <= 730
    error_message = "log_retention_in_days must be between 30 and 730."
  }
}
