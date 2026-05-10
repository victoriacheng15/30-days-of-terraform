output "resource_address" {
  description = "The OpenTofu address for the lab resource."
  value       = "null_resource.state_probe"
}

output "resource_id" {
  description = "The provider-generated ID stored in state."
  value       = null_resource.state_probe.id
}

output "tracked_values" {
  description = "The trigger values recorded for the resource."
  value       = null_resource.state_probe.triggers
}
