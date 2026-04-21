output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "resource_group_location" {
  value       = azurerm_resource_group.main.location
  description = "Resource group location"
}

output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Storage account name"
}

output "security_settings" {
  value = {
    min_tls_version                 = azurerm_storage_account.main.min_tls_version
    https_traffic_only_enabled      = azurerm_storage_account.main.https_traffic_only_enabled
    allow_nested_items_to_be_public = azurerm_storage_account.main.allow_nested_items_to_be_public
    logs_container_access_type      = azurerm_storage_container.logs.container_access_type
  }
  description = "Security baseline values used for automated tests"
}
