output "redis_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Redis Container Instance"
  value       = module.aci_redis.redis_fqdn
}

output "aca_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure Container App"
  value       = module.aca.aca_fqdn
}

output "aks_lb_ip" {
  description = "LoadBalancer Public IP for the Flask Application"
  value       = module.k8s.aks_lb_ip
}
