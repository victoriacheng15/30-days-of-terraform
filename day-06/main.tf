# day-06/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Fetch current subscription information using a data source
# This is a classic "peeking" data source.
data "azurerm_subscription" "current" {}

# 2. Create a Resource Group and VNet
# This creates the physical infrastructure.
resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "lab" {
  name                = var.vnet_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = ["10.0.0.0/16"]
}

# 3. Use a data source to "Look Up" the VNet we just created
# This demonstrates the "Read-Only" mode. 
data "azurerm_virtual_network" "lookup" {
  # This data source will fail until the resource is created by OpenTofu!
  name                = azurerm_virtual_network.lab.name
  resource_group_name = azurerm_virtual_network.lab.resource_group_name
}
