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

# 1. Resource Group
resource "azurerm_resource_group" "frontdoor" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Front Door profile and endpoint
resource "azurerm_cdn_frontdoor_profile" "fd" {
  name                = var.frontdoor_profile_name
  resource_group_name = azurerm_resource_group.frontdoor.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fd" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd.id
}

# 3. Origin group and origins (primary + secondary region)
resource "azurerm_cdn_frontdoor_origin_group" "apps" {
  name                     = "og-appservices"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd.id

  session_affinity_enabled = false

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }

  health_probe {
    interval_in_seconds = 120
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
}

resource "azurerm_cdn_frontdoor_origin" "primary" {
  name                          = "origin-primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.apps.id

  enabled                        = true
  host_name                      = var.primary_origin_host
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = var.primary_origin_host
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_origin" "secondary" {
  name                          = "origin-secondary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.apps.id

  enabled                        = true
  host_name                      = var.secondary_origin_host
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = var.secondary_origin_host
  priority                       = 2
  weight                         = 1000
  certificate_name_check_enabled = true
}

# 4. Route traffic through Front Door default domain
resource "azurerm_cdn_frontdoor_route" "default" {
  name                          = "route-default"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.apps.id
  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary.id,
    azurerm_cdn_frontdoor_origin.secondary.id
  ]

  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  link_to_default_domain = true
}

# 5. WAF policy and association to Front Door endpoint
resource "azurerm_cdn_frontdoor_firewall_policy" "waf" {
  name                = var.waf_policy_name
  resource_group_name = azurerm_resource_group.frontdoor.name
  sku_name            = azurerm_cdn_frontdoor_profile.fd.sku_name
  enabled             = true
  mode                = "Prevention"
}

resource "azurerm_cdn_frontdoor_security_policy" "waf" {
  name                     = "sp-frontdoor-waf"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.waf.id

      association {
        patterns_to_match = ["/*"]

        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.fd.id
        }
      }
    }
  }
}
