output "aks_lb_ip" {
  description = "LoadBalancer Public IP for the Flask Application"
  value       = data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip
}
