output "aks_identity_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "kube_config" {
  description = "Kubernetes cluster configuration"
  value = {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_certificate     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
    client_key             = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  }
  sensitive = true
}
