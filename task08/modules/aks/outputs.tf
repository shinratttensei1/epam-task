output "aks_identity_id" {
  value = azurerm_user_assigned_identity.aks_identity.id
}


output "kube_config" {
  description = "Kubeconfig required for kubectl provider"
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
}
