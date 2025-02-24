output "aks_id" {
  description = "AKS Cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kv_access_identity_id" {
  description = "AKS User-Assigned Identity Client ID"
  value       = azurerm_user_assigned_identity.aks_identity.client_id
}

output "aks_lb_ip" {
  description = "AKS LoadBalancer Public IP"
  value       = azurerm_kubernetes_cluster.aks.network_profile[0].load_balancer_sku
}

output "kube_config" {
  description = "Kubeconfig for Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}
