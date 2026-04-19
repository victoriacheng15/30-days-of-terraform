output "resource_group_id" {
  value       = azurerm_resource_group.main.id
  description = "Resource group ID"
}

output "vnet_id" {
  value       = azurerm_virtual_network.main.id
  description = "Virtual network ID"
}

output "app_service_id" {
  value       = azurerm_linux_web_app.main.id
  description = "App Service ID"
}

output "app_service_url" {
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
  description = "App Service default URL"
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
  description = "SQL Server fully qualified domain name"
}

output "key_vault_id" {
  value       = azurerm_key_vault.main.id
  description = "Key Vault ID"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.main.vault_uri
  description = "Key Vault URI"
}

output "application_gateway_id" {
  value       = azurerm_application_gateway.main.id
  description = "Application Gateway ID"
}

output "application_gateway_public_ip" {
  value       = azurerm_public_ip.application_gateway.ip_address
  description = "Application Gateway public IP"
}
