# day-06/outputs.tf

output "subscription_id" {
  value       = data.azurerm_subscription.current.subscription_id
  description = "Example of using a data source to see account details."
}

output "resource_vnet_id" {
  value       = azurerm_virtual_network.lab.id
  description = "The ID of the VNet created by our 'resource' block."
}

output "data_vnet_id" {
  value       = data.azurerm_virtual_network.lookup.id
  description = "The ID of the same VNet, as 'discovered' by the data source."
}

output "vnet_address_space" {
  # This value is fetched via the data source
  value       = data.azurerm_virtual_network.lookup.address_space
  description = "The address space discovered by the data source."
}
