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

resource "azurerm_resource_group" "cost_mgmt" {
  name     = var.resource_group_name
  location = var.location
}

# Budget Alert - Monthly threshold
resource "azurerm_consumption_budget_subscription" "monthly" {
  name            = "budget-monthly"
  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  amount          = var.monthly_budget_amount
  time_grain      = "Monthly"

  time_period {
    start_date = "${formatdate("YYYY-MM-01", timestamp())}T00:00:00Z"
    end_date   = "2099-12-31T23:59:59Z"
  }

  notification {
    enabled        = true
    threshold      = var.budget_alert_threshold_percentage
    threshold_type = "Forecasted"
    operator       = "GreaterThan"
    contact_emails = var.alert_email_addresses
  }

  notification {
    enabled        = true
    threshold      = 100
    threshold_type = "Actual"
    operator       = "GreaterThanOrEqualTo"
    contact_emails = var.alert_email_addresses
  }
}

# Policy Definition: Mandatory tags enforcement
resource "azurerm_policy_definition" "mandatory_tags" {
  name         = "MandatoryTags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Mandatory Tags"
  description  = "Enforce mandatory tags for cost allocation and governance"

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          anyOf = [
            {
              field       = "tags"
              notContains = "costCenter"
            },
            {
              field       = "tags"
              notContains = "environment"
            },
            {
              field       = "tags"
              notContains = "owner"
            }
          ]
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy Assignment: Mandatory tags at subscription scope
resource "azurerm_subscription_policy_assignment" "mandatory_tags" {
  name                 = "enforce-tags"
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_definition_id = azurerm_policy_definition.mandatory_tags.id
}

# Data source for current subscription/tenant context
data "azurerm_client_config" "current" {}
