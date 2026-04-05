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

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix
  sku_tier            = "Free"

  default_node_pool {
    name                = "systempool"
    vm_size             = var.vm_size
    auto_scaling_enabled = true
    min_count           = var.min_count
    max_count           = var.max_count
    os_disk_size_gb     = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Day         = "14"
  }
}
