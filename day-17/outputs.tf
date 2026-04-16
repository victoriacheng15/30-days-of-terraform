output "app_service_url" {
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
  description = "The default URL of the App Service"
}

output "vnet_integration_subnet_id" {
  value       = azurerm_subnet.snet_integration.id
  description = "The ID of the subnet used for VNet integration"
}

output "sql_private_fqdn" {
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  description = "The private FQDN of the SQL Server"
}
