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

data "azurerm_client_config" "current" {}

# 1. Resource Group for observability resources
resource "azurerm_resource_group" "monitor" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Log Analytics workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.monitor.location
  resource_group_name = azurerm_resource_group.monitor.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_in_days
}

# 3. Send subscription activity/resource-health logs to Log Analytics
resource "azurerm_monitor_diagnostic_setting" "subscription" {
  name                       = "diag-subscription-to-law"
  target_resource_id         = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log { category = "Administrative" }
  enabled_log { category = "Security" }
  enabled_log { category = "ServiceHealth" }
  enabled_log { category = "Alert" }
  enabled_log { category = "Recommendation" }
  enabled_log { category = "Policy" }
  enabled_log { category = "Autoscale" }
  enabled_log { category = "ResourceHealth" }
}

# 4. Saved KQL queries for quick observability checks
resource "azurerm_log_analytics_saved_search" "resource_activity" {
  name                       = "ResourceActivityLast24h"
  category                   = "day-20-observability"
  display_name               = "Resource Activity (Last 24h)"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  query = <<-KQL
    AzureActivity
    | where TimeGenerated > ago(24h)
    | where ResourceGroup =~ "${azurerm_resource_group.monitor.name}"
    | project TimeGenerated, OperationNameValue, ActivityStatusValue, ResourceProviderValue, CorrelationId
    | order by TimeGenerated desc
  KQL
}

resource "azurerm_log_analytics_saved_search" "resource_health" {
  name                       = "ResourceHealthEventsLast24h"
  category                   = "day-20-observability"
  display_name               = "Resource Health Events (Last 24h)"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  query = <<-KQL
    AzureActivity
    | where TimeGenerated > ago(24h)
    | where OperationNameValue has "MICROSOFT.RESOURCEHEALTH"
    | project TimeGenerated, OperationNameValue, ActivityStatusValue, ResourceId
    | order by TimeGenerated desc
  KQL
}
