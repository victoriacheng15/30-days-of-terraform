output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}

output "private_fqdn" {
  description = "The FQDN of the private API server."
  value       = azurerm_kubernetes_cluster.aks.private_fqdn
}
