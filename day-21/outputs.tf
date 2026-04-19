output "resource_group_id" {
  value       = azurerm_resource_group.policy.id
  description = "The ID of the resource group"
}

output "resource_group_name" {
  value       = azurerm_resource_group.policy.name
  description = "The name of the resource group"
}

output "allowed_locations_policy_id" {
  value       = azurerm_policy_definition.allowed_locations.id
  description = "The ID of the allowed locations policy definition"
}

output "naming_convention_policy_id" {
  value       = azurerm_policy_definition.naming_convention.id
  description = "The ID of the naming convention policy definition"
}

output "allowed_locations_assignment_id" {
  value       = azurerm_subscription_policy_assignment.allowed_locations.id
  description = "The ID of the allowed locations policy assignment"
}

output "naming_convention_assignment_id" {
  value       = azurerm_subscription_policy_assignment.naming_convention.id
  description = "The ID of the naming convention policy assignment"
}
