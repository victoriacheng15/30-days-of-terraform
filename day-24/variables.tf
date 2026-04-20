variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day24-modules"

  validation {
    condition     = can(regex("^rg-", var.resource_group_name))
    error_message = "Resource group name must start with 'rg-'."
  }
}

variable "location" {
  type        = string
  description = "Azure region for resources"
  default     = "canadacentral"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "storage_account_name_prefix" {
  type        = string
  description = "Lowercase prefix for the storage account name. A random suffix is added for uniqueness."
  default     = "std24mod"

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.storage_account_name_prefix))
    error_message = "storage_account_name_prefix must be 3-18 chars, lowercase letters and numbers only."
  }
}

variable "storage_account_tier" {
  type        = string
  description = "Storage account tier"
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "storage_account_tier must be Standard or Premium."
  }
}

variable "storage_account_replication_type" {
  type        = string
  description = "Storage replication type"
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_account_replication_type)
    error_message = "storage_account_replication_type must be one of LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags applied to all resources"
  default     = {}
}
