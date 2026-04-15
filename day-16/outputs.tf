output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server"
}

output "private_endpoint_ip" {
  value       = azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address
  description = "The private IP address of the SQL Server Private Endpoint"
}

output "storage_account_audit_name" {
  value       = azurerm_storage_account.audit.name
  description = "The name of the storage account used for auditing"
}
