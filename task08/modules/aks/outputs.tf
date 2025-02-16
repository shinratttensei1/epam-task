output "aks_identity_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "kube_config" {
  description = "Kubeconfig required for kubectl provider"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0]
  sensitive   = true
}
