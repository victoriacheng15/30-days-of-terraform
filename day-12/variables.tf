variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-day-12-secrets"
}

variable "keyvault_name" {
  description = "The name of the key vault. Must be globally unique."
  type        = string
  default     = "kvday12secrets789"
}

variable "identity_name" {
  description = "The name of the unique identity."
  type        = string
  default     = "id-keyvault-app"
}
