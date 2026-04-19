output "resource_group_id" {
  value       = azurerm_resource_group.cost_mgmt.id
  description = "The ID of the resource group"
}

output "resource_group_name" {
  value       = azurerm_resource_group.cost_mgmt.name
  description = "The name of the resource group"
}

output "budget_alert_id" {
  value       = azurerm_consumption_budget_subscription.monthly.id
  description = "The ID of the monthly budget alert"
}

output "mandatory_tags_policy_id" {
  value       = azurerm_policy_definition.mandatory_tags.id
  description = "The ID of the mandatory tags policy definition"
}

output "mandatory_tags_assignment_id" {
  value       = azurerm_subscription_policy_assignment.mandatory_tags.id
  description = "The ID of the mandatory tags policy assignment"
}
