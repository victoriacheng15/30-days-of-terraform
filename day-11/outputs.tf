output "identity_id" {
  value = azurerm_user_assigned_identity.app_reader.id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.app_reader.principal_id
}

output "storage_account_id" {
  value = azurerm_storage_account.data.id
}

output "role_assignment_id" {
  value = azurerm_role_assignment.reader_assignment.id
}
