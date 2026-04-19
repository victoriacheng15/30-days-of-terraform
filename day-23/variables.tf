variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day23-paas"

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

variable "app_service_sku" {
  type        = string
  description = "App Service Plan SKU"
  default     = "P1v2"
}

variable "database_name" {
  type        = string
  description = "SQL Database name"
  default     = "appdb"
}

variable "database_admin_username" {
  type        = string
  description = "SQL Server admin username"
  default     = "sqladmin"
  sensitive   = true
}

# WARNING: This password is hardcoded for learning purposes only.
# NEVER commit passwords to GitHub in production environments.
# This entire resource will be destroyed after the lab is completed.
# For production, use Azure Key Vault, Secrets Manager, or environment variables.
variable "database_admin_password" {
  type        = string
  description = "SQL Server admin password"
  default     = "P@ssw0rd1234!"
  sensitive   = true

  validation {
    condition     = length(var.database_admin_password) >= 8
    error_message = "Database password must be at least 8 characters."
  }
}
