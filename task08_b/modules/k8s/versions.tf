terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = ">=2.0.0"
    }
    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=1.1"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
  }
}

