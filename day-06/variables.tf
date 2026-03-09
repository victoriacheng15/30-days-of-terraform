# day-06/variables.tf

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed."
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "rg-day-06-lab"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "vnet-day-06-demo"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
  default = {
    environment = "lab"
    owner       = "opentofu-learner"
    day         = "06"
  }
}
