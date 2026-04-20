output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "virtual_network_ids" {
  value       = { for k, v in azurerm_virtual_network.main : k => v.id }
  description = "Virtual network IDs by key"
}

output "subnet_ids" {
  value       = { for k, v in azurerm_subnet.main : k => v.id }
  description = "Subnet IDs by vnet-subnet key"
}

output "network_security_group_ids" {
  value       = { for k, v in azurerm_network_security_group.main : k => v.id }
  description = "NSG IDs by vnet-subnet key"
}

output "diagnostics_storage_account_name" {
  value       = var.create_diagnostics_storage ? azurerm_storage_account.diagnostics[0].name : null
  description = "Diagnostics storage account name when count is enabled"
}
