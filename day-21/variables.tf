variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day21-policy"

  validation {
    condition     = can(regex("^rg-", var.resource_group_name))
    error_message = "Resource group name must start with 'rg-'."
  }
}

variable "location" {
  type        = string
  description = "Azure region for the resource group"
  default     = "eastus"
}

variable "allowed_locations" {
  type        = list(string)
  description = "List of allowed Azure locations for resource deployments"
  default     = ["eastus", "eastus2", "westus", "westus2"]
}
