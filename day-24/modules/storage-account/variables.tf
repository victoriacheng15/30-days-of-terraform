variable "name_prefix" {
  type        = string
  description = "Lowercase storage account prefix. Random suffix is appended."

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.name_prefix))
    error_message = "name_prefix must be 3-18 chars, lowercase letters and numbers only."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where the storage account is created"
}

variable "location" {
  type        = string
  description = "Azure region for storage account"
}

variable "environment" {
  type        = string
  description = "Environment tag value"
}

variable "account_tier" {
  type        = string
  description = "Storage account tier"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Storage account replication type"
  default     = "LRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the storage account"
  default     = {}
}
