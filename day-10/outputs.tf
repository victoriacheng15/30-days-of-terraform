output "resource_group_name" {
  value = azurerm_resource_group.security.name
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "frontend_nsg_id" {
  value = azurerm_network_security_group.frontend.id
}

output "backend_nsg_id" {
  value = azurerm_network_security_group.backend.id
}

output "database_nsg_id" {
  value = azurerm_network_security_group.database.id
}
