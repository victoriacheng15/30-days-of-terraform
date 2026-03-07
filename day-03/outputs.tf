# day-03/outputs.tf

output "current_location" {
  value       = var.location
  description = "The region selected for deployment."
}

output "deployment_tags" {
  value       = var.tags
  description = "The tags assigned to the infrastructure."
}

output "primary_tag" {
  value       = lookup(var.tags, "environment", "undefined")
  description = "Example of using the lookup function on a map."
}

output "ip_count" {
  value       = length(var.allowed_ips)
  description = "The number of allowed IPs in the list."
}

output "formatted_region" {
  value       = upper(var.location)
  description = "Example of a string transformation."
}
