variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-day-11-identity"
}

variable "identity_name" {
  description = "The name of the user assigned managed identity."
  type        = string
  default     = "id-app-reader"
}

variable "storage_account_name" {
  description = "The name of the storage account. Must be globally unique."
  type        = string
  default     = "stday11identity345"
}
