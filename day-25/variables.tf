variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day25-expressions"

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

variable "vnets" {
  type = map(object({
    address_space = list(string)
    subnets = map(object({
      address_prefixes = list(string)
    }))
  }))
  description = "Virtual networks and subnets created with for_each"

  default = {
    app = {
      address_space = ["10.25.0.0/16"]
      subnets = {
        web = {
          address_prefixes = ["10.25.1.0/24"]
        }
        api = {
          address_prefixes = ["10.25.2.0/24"]
        }
      }
    }
    data = {
      address_space = ["10.26.0.0/16"]
      subnets = {
        db = {
          address_prefixes = ["10.26.1.0/24"]
        }
      }
    }
  }
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "NSG rules rendered with a dynamic block for each subnet NSG"

  default = [
    {
      name                       = "AllowHTTPSIn"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTPIn"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "create_diagnostics_storage" {
  type        = bool
  description = "When true, create one diagnostics storage account using count"
  default     = false
}

variable "storage_account_name_prefix" {
  type        = string
  description = "Lowercase prefix for optional diagnostics storage account"
  default     = "std25diag"

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.storage_account_name_prefix))
    error_message = "storage_account_name_prefix must be 3-18 chars, lowercase letters and numbers only."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags applied to all resources"
  default     = {}
}
