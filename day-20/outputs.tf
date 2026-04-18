output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_customer_id" {
  description = "Workspace ID used for Log Analytics queries"
  value       = azurerm_log_analytics_workspace.main.workspace_id
}

output "subscription_diagnostic_setting_id" {
  description = "Diagnostic setting resource ID for subscription-level activity logs"
  value       = azurerm_monitor_diagnostic_setting.subscription.id
}

output "saved_searches_category" {
  description = "Category in Log Analytics where Day 20 saved KQL queries are stored"
  value       = azurerm_log_analytics_saved_search.resource_activity.category
}
