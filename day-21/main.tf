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

resource "azurerm_resource_group" "policy" {
  name     = var.resource_group_name
  location = var.location
}

# Policy Definition: Allowed locations
resource "azurerm_policy_definition" "allowed_locations" {
  name         = "AllowedLocations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed Locations"
  description  = "This policy ensures resources are only deployed to approved regions"

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          field = "location"
          notIn = "[parameters('allowedLocations')]"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        description = "The list of allowed locations for new resources."
        strongType  = "location"
        displayName = "Allowed locations"
      }
    }
  })
}

# Policy Definition: Naming convention enforcement
resource "azurerm_policy_definition" "naming_convention" {
  name         = "NamingConvention"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Naming Convention"
  description  = "This policy enforces naming conventions for resources (prefix required)"

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          field   = "name"
          notLike = "vm-*"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy Assignment: Allowed locations at subscription scope
resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  name                 = "allow-locations"
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_definition_id = azurerm_policy_definition.allowed_locations.id

  parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
    }
  })
}

# Policy Assignment: Naming convention
resource "azurerm_subscription_policy_assignment" "naming_convention" {
  name                 = "naming-conv"
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_definition_id = azurerm_policy_definition.naming_convention.id
}

# Data source to get current subscription/tenant context
data "azurerm_client_config" "current" {}
