output "resource_group_id" {
  value       = module.resource_group.id
  description = "Resource group ID"
}

output "resource_group_name" {
  value       = module.resource_group.name
  description = "Resource group name"
}

output "storage_account_id" {
  value       = module.storage_account.id
  description = "Storage account ID"
}

output "storage_account_name" {
  value       = module.storage_account.name
  description = "Storage account name"
}

output "storage_account_primary_blob_endpoint" {
  value       = module.storage_account.primary_blob_endpoint
  description = "Primary blob endpoint for the storage account"
}
