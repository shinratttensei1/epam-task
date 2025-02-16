terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }

    kubectl = {
      source  = "alekc/kubectl"
      version = ">=2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = true
}

provider "kubectl" {
  host                   = module.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
  token                  = module.aks.kube_config[0].password
  load_config_file       = false
}
