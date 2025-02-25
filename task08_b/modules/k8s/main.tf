data "azurerm_client_config" "current" {}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("./k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = var.aks_identity_id
    kv_name                    = var.kv_name
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-password"
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })
}

resource "kubectl_manifest" "app_deployment" {
  yaml_body = templatefile("./k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = var.acr_login_server
    app_image_name   = var.docker_image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]

}

resource "kubectl_manifest" "app_service" {
  yaml_body = file("./k8s-manifests/service.yaml")
  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.app_service]
}
