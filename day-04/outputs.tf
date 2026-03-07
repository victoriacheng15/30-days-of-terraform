# day-04/outputs.tf

output "resource_group_id" {
  value       = azurerm_resource_group.lab.id
  description = "The Azure ID of the newly created resource group."
}

output "lifecycle_example_id" {
  value       = null_resource.example.id
  description = "The ID of the primary null resource."
}

output "secondary_id" {
  value       = null_resource.secondary.id
  description = "The ID of the secondary null resource."
}
