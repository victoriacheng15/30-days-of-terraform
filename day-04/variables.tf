# day-04/variables.tf

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed."
  default     = "eastus"

  validation {
    condition     = contains(["eastus", "westus", "canadacentral"], var.location)
    error_message = "Only eastus, westus, or canadacentral regions are permitted for this lab."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "rg-day-04-lab"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
  default = {
    environment = "lab"
    owner       = "opentofu-learner"
    day         = "04"
  }
}
