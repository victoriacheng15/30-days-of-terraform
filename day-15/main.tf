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

# 1. Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-day-15"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = var.vnet_address_space
}

# 2. Create Subnet for AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.aks_subnet_address_prefix
}

# 3. Create Private DNS Zone for AKS
resource "azurerm_private_dns_zone" "aks_dns" {
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = azurerm_resource_group.aks.name
}

# 4. Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "aks-dns-link"
  resource_group_name   = azurerm_resource_group.aks.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# 5. Create User Assigned Identity for AKS
resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "id-aks-day15"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

# 6. Grant Identity permissions on the DNS Zone
resource "azurerm_role_assignment" "dns_contributor" {
  scope                = azurerm_private_dns_zone.aks_dns.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

# 7. Grant Identity permissions on the Network (Subnet)
resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

# 8. Provision Private AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.cluster_name
  location                = azurerm_resource_group.aks.location
  resource_group_name     = azurerm_resource_group.aks.name
  dns_prefix              = var.dns_prefix
  private_cluster_enabled = true
  sku_tier                = "Free"

  private_dns_zone_id = azurerm_private_dns_zone.aks_dns.id

  default_node_pool {
    name            = "systempool"
    vm_size         = var.vm_size
    node_count      = 1
    vnet_subnet_id  = azurerm_subnet.aks_subnet.id
    os_disk_size_gb = 30
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dns_link,
    azurerm_role_assignment.dns_contributor,
    azurerm_role_assignment.network_contributor
  ]

  tags = {
    Environment = "Project"
    Project     = "Secure-AKS"
    Day         = "15"
  }
}
