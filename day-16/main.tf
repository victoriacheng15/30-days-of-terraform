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

# 1. Resource Group
resource "azurerm_resource_group" "sql" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Virtual Network & Subnet for Private Endpoint
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-day16"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sql.location
  resource_group_name = azurerm_resource_group.sql.name
}

resource "azurerm_subnet" "snet" {
  name                 = "snet-sql-pe"
  resource_group_name  = azurerm_resource_group.sql.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 3. Random String for Unique SQL Server Name
resource "random_string" "sql_name" {
  length  = 8
  upper   = false
  special = false
}

# 4. Storage Account for Auditing Logs
resource "azurerm_storage_account" "audit" {
  name                     = "stda16audit${random_string.sql_name.result}"
  resource_group_name      = azurerm_resource_group.sql.name
  location                 = azurerm_resource_group.sql.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 5. Azure SQL Server (Public Access Disabled)
resource "azurerm_mssql_server" "sql" {
  name                         = "sql-day16-${random_string.sql_name.result}"
  resource_group_name          = azurerm_resource_group.sql.name
  location                     = azurerm_resource_group.sql.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  public_network_access_enabled = false # BLOCK PUBLIC INTERNET
}

# 6. Azure SQL Database
resource "azurerm_mssql_database" "db" {
  name      = "db-day16"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic" # Cost optimization for lab
}

# 7. Private DNS Zone for SQL
resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.sql.name
}

# 8. Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "sql-dns-link"
  resource_group_name   = azurerm_resource_group.sql.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# 9. Private Endpoint for SQL Server
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "pe-sql-day16"
  location            = azurerm_resource_group.sql.location
  resource_group_name = azurerm_resource_group.sql.name
  subnet_id           = azurerm_subnet.snet.id

  private_service_connection {
    name                           = "sql-privatelink"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql_dns.id]
  }
}

# 10. Extended Auditing Policy (Security Practice)
resource "azurerm_mssql_server_extended_auditing_policy" "audit" {
  server_id              = azurerm_mssql_server.sql.id
  storage_endpoint       = azurerm_storage_account.audit.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.audit.primary_access_key
  retention_in_days      = 7
}
