output "key_vault_uri" {
  value = azurerm_key_vault.vault.vault_uri
}

output "secret_id" {
  value = azurerm_key_vault_secret.db_password.id
  sensitive = true
}

output "identity_name" {
  value = azurerm_user_assigned_identity.app_reader.name
}
