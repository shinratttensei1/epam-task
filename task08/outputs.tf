output "aci_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure Container Instance"
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the App in AKS"
  value       = data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip
}
