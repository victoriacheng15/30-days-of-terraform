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

locals {
  frontend_listener_name = var.enable_https ? "listener-https" : "listener-http"
}

# 1. Resource Group
resource "azurerm_resource_group" "appgw" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Networking for Application Gateway
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-day18"
  location            = azurerm_resource_group.appgw.location
  resource_group_name = azurerm_resource_group.appgw.name
  address_space       = var.vnet_address_space
}

# Dedicated subnet is required for Application Gateway
resource "azurerm_subnet" "appgw" {
  name                 = "snet-appgw"
  resource_group_name  = azurerm_resource_group.appgw.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.appgw_subnet_prefixes
}

# 3. Public frontend IP
resource "azurerm_public_ip" "appgw" {
  name                = "pip-day18-appgw"
  location            = azurerm_resource_group.appgw.location
  resource_group_name = azurerm_resource_group.appgw.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# 4. WAF Policy
resource "azurerm_web_application_firewall_policy" "waf" {
  name                = "waf-day18-policy"
  resource_group_name = azurerm_resource_group.appgw.name
  location            = azurerm_resource_group.appgw.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    max_request_body_size_in_kb = 128
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

# 5. Application Gateway with path-based routing
resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  location            = azurerm_resource_group.appgw.location
  resource_group_name = azurerm_resource_group.appgw.name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = var.app_gateway_capacity
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.waf.id

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.appgw.id
  }

  frontend_port {
    name = "port-80"
    port = 80
  }

  frontend_port {
    name = "port-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend-public"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  dynamic "ssl_certificate" {
    for_each = var.enable_https ? [1] : []
    content {
      name     = "ssl-cert"
      data     = var.ssl_certificate_data
      password = var.ssl_certificate_password
    }
  }

  backend_address_pool {
    name  = "pool-web"
    fqdns = [var.web_backend_fqdn]
  }

  backend_address_pool {
    name  = "pool-api"
    fqdns = [var.api_backend_fqdn]
  }

  backend_http_settings {
    name                                = "bhs-web"
    protocol                            = "Https"
    port                                = 443
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 30
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                                = "bhs-api"
    protocol                            = "Https"
    port                                = 443
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 30
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "listener-http"
    frontend_ip_configuration_name = "frontend-public"
    frontend_port_name             = "port-80"
    protocol                       = "Http"
  }

  dynamic "http_listener" {
    for_each = var.enable_https ? [1] : []
    content {
      name                           = "listener-https"
      frontend_ip_configuration_name = "frontend-public"
      frontend_port_name             = "port-443"
      protocol                       = "Https"
      ssl_certificate_name           = "ssl-cert"
    }
  }

  url_path_map {
    name                               = "path-map-day18"
    default_backend_address_pool_name  = "pool-web"
    default_backend_http_settings_name = "bhs-web"

    path_rule {
      name                       = "api-route"
      paths                      = ["/api/*"]
      backend_address_pool_name  = "pool-api"
      backend_http_settings_name = "bhs-api"
    }
  }

  request_routing_rule {
    name               = "path-routing-rule"
    rule_type          = "PathBasedRouting"
    http_listener_name = local.frontend_listener_name
    url_path_map_name  = "path-map-day18"
    priority           = 100
  }
}
