output "aks_identity_id" {
  value = azurerm_user_assigned_identity.aks_identity.id
}


output "kube_config" {
  description = "Kubeconfig required for kubectl provider"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0]
  sensitive   = true
}

output "aks_secret_provider_object_id" {
  description = "Object ID of the AKS Secret Provider Identity"
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
}

output "aks_kubelet_object_id" {
  description = "Object ID of the AKS Secret Provider Identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "aks_kv_access_identity_id" {
  description = "Object ID of the AKS Secret Provider Identity"
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

