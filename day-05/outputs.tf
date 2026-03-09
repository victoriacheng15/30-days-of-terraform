# day-05/outputs.tf

output "resource_group_name" {
  value       = azurerm_resource_group.lab.name
  description = "The name of the base resource group."
}

output "implicit_resource_id" {
  value       = null_resource.implicit.id
  description = "The ID of the implicit dependency resource."
}

output "explicit_resource_id" {
  value       = null_resource.explicit.id
  description = "The ID of the explicit dependency resource."
}
