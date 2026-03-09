output "website_url" {
  value       = azurerm_storage_account.website.primary_web_endpoint
  description = "The URL of the static website."
}

output "storage_account_name" {
  value = azurerm_storage_account.website.name
}
