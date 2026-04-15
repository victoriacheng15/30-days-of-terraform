variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-day16-sql-security"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "West US 2"
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL Server"
  type        = string
  sensitive   = true
}
