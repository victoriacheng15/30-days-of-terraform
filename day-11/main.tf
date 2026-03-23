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

resource "azurerm_resource_group" "identity" {
  name     = var.resource_group_name
  location = var.location
}

# 1. Create User Assigned Managed Identity
resource "azurerm_user_assigned_identity" "app_reader" {
  name                = var.identity_name
  resource_group_name = azurerm_resource_group.identity.name
  location            = azurerm_resource_group.identity.location
}

# 2. Create Storage Account (Target Resource)
resource "azurerm_storage_account" "data" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.identity.name
  location                 = azurerm_resource_group.identity.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 3. Role Assignment (RBAC)
# Assign 'Storage Blob Data Reader' to our Identity for the specific Storage Account
resource "azurerm_role_assignment" "reader_assignment" {
  scope                = azurerm_storage_account.data.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.app_reader.principal_id
}
