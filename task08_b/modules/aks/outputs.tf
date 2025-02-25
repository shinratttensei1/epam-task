output "aks_id" {
  description = "AKS Cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kv_access_identity_id" {
  description = "AKS User-Assigned Identity Client ID"
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
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

output "aks_identity_principal_id" {
  value = azurerm_user_assigned_identity.aks_identity.principal_id
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "kv_secrets_provider_identity_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

