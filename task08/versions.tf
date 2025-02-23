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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = "d7f93255-c025-4287-8a8a-e60dd8e868bf"
  use_cli         = true
}


