# from https://registry.terraform.io/providers/hashicorp/azurerm/latest

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.64.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}

provider "azurerm" {
    features {}
}

provider "helm" {
  kubernetes {
    host = azurerm_kubernetes_cluster.main.kube_config[0].host

    client_certificate     = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
  }
}