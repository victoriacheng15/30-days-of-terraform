terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # REUSING THE REMOTE BACKEND
  backend "azurerm" {
    resource_group_name  = "rg-tofu-state-mgmt"
    storage_account_name = "tofustate17871"
    container_name       = "tfstate"
    key                  = "day-09.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "networking" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-day-09"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnet_prefixes
  name                 = each.key
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]
}
