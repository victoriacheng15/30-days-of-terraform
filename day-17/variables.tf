variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-day17-app-service-vnet"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "West US 2"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "app-day17-vnet"
}
