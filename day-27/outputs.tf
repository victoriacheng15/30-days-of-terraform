output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "storage_account_name" {
  value       = azurerm_storage_account.state.name
  description = "Storage account name"
}
