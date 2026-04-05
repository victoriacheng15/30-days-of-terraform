output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "node_pool_name" {
  value = azurerm_kubernetes_cluster.aks.default_node_pool[0].name
}
