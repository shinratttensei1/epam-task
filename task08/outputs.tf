output "aci_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure Container Instance"
  value       = module.aci.fqdn
}

/*
output "aks_lb_ip" {
  description = "Load Balancer IP address of the application running on AKS"
  value       = try(jsondecode(jsonencode(data.kubernetes_service.app_service.status)).load_balancer.ingress[0].ip, null)
}
*/
