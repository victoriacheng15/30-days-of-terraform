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
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

# Get the current client configuration (Your identity)
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "secrets" {
  name     = var.resource_group_name
  location = var.location
}

# 1. Create User Assigned Managed Identity for Day 12
resource "azurerm_user_assigned_identity" "app_reader" {
  name                = var.identity_name
  resource_group_name = azurerm_resource_group.secrets.name
  location            = azurerm_resource_group.secrets.location
}

# 2. Provision Key Vault
resource "azurerm_key_vault" "vault" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.secrets.location
  resource_group_name         = azurerm_resource_group.secrets.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  # Recommended for 4.x
  rbac_authorization_enabled = true
}

# 3. Grant the CURRENT CALLER (You) 'Key Vault Secrets Officer' permissions
# Without this, Terraform cannot create the secret in an RBAC-enabled vault.
resource "azurerm_role_assignment" "terraform_caller_kv_admin" {
  scope                = azurerm_key_vault.vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# 4. Generate a secure random password
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# 5. Store the generated password in Key Vault
# NOTE: This depends on the role assignment above being finished first.
resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = random_password.db_password.result
  key_vault_id = azurerm_key_vault.vault.id

  depends_on = [azurerm_role_assignment.terraform_caller_kv_admin]
}

# 6. Grant the Managed Identity 'Key Vault Secrets User' permissions
resource "azurerm_role_assignment" "kv_reader" {
  scope                = azurerm_key_vault.vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.app_reader.principal_id
}
