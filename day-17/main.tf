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
resource "azurerm_resource_group" "app" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Virtual Network & Subnets
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-day17"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
}

# Subnet for VNet Integration (Outbound) - REQUIRES DELEGATION
resource "azurerm_subnet" "snet_integration" {
  name                 = "snet-app-integration"
  resource_group_name  = azurerm_resource_group.app.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]

  delegation {
    name = "appservice-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Subnet for SQL Private Endpoint (The Backend)
resource "azurerm_subnet" "snet_sql" {
  name                 = "snet-sql-backend"
  resource_group_name  = azurerm_resource_group.app.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

# 3. SQL Setup (Miniature Day 16)
resource "random_string" "sql_name" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_mssql_server" "sql" {
  name                          = "sql-day17-${random_string.sql_name.result}"
  resource_group_name           = azurerm_resource_group.app.name
  location                      = azurerm_resource_group.app.location
  version                       = "12.0"
  administrator_login           = "sqladmin"
  administrator_login_password  = "ComplexPassword123!"
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "db" {
  name      = "db-day17"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}

resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.app.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "sql-dns-link-day17"
  resource_group_name   = azurerm_resource_group.app.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "pe-sql-day17"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  subnet_id           = azurerm_subnet.snet_sql.id

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

# 4. App Service Plan (Basic B1 is the minimum for VNet Integration)
resource "azurerm_service_plan" "plan" {
  name                = "plan-day17"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# 5. Linux Web App with VNet Integration
resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_service_name}-${random_string.sql_name.result}"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location
  service_plan_id     = azurerm_service_plan.plan.id

  # OUTBOUND: This connects the App to the VNet
  virtual_network_subnet_id = azurerm_subnet.snet_integration.id

  site_config {
    always_on              = false
    vnet_route_all_enabled = true # FORCES TRAFFIC (INCLUDING DNS) INTO VNET
  }

  app_settings = {
    "DB_SERVER" = azurerm_mssql_server.sql.fully_qualified_domain_name
    "DB_NAME"   = azurerm_mssql_database.db.name
  }

  connection_string {
    name  = "SqlConnectionString"
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};Persist Security Info=False;User ID=sqladmin;Password=ComplexPassword123!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  identity {
    type = "SystemAssigned"
  }
}
