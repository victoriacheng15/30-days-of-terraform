terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = merge(
    {
      environment = var.environment
      project     = "30-days-of-opentofu"
      day         = "25"
    },
    var.common_tags
  )

  subnet_matrix = flatten([
    for vnet_name, vnet in var.vnets : [
      for subnet_name, subnet in vnet.subnets : {
        key              = "${vnet_name}-${subnet_name}"
        vnet_name        = vnet_name
        subnet_name      = subnet_name
        address_prefixes = subnet.address_prefixes
      }
    ]
  ])

  subnet_map = { for s in local.subnet_matrix : s.key => s }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "main" {
  for_each = var.vnets

  name                = "vnet-${var.environment}-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = each.value.address_space
  tags                = local.tags
}

resource "azurerm_subnet" "main" {
  for_each = local.subnet_map

  name                 = "snet-${each.value.subnet_name}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main[each.value.vnet_name].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "main" {
  for_each = local.subnet_map

  name                = "nsg-${var.environment}-${each.value.subnet_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  for_each = local.subnet_map

  subnet_id                 = azurerm_subnet.main[each.key].id
  network_security_group_id = azurerm_network_security_group.main[each.key].id
}

resource "random_string" "diagnostics_suffix" {
  count = var.create_diagnostics_storage ? 1 : 0

  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "diagnostics" {
  count = var.create_diagnostics_storage ? 1 : 0

  name                            = lower("${var.storage_account_name_prefix}${random_string.diagnostics_suffix[0].result}")
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  tags                            = local.tags
}
