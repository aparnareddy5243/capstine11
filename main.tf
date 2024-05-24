terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.99.0"
    }
  }
  required_version = ">= 0.14.9"

  backend "azurerm" {
    resource_group_name  = "ap_rg1"
    storage_account_name = "terraform524"
    container_name       = "container52"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "appu-capstone-aks" {
  name     = "appu-capstone-aks"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks_cluster_capstone_appu" {
  name                = "aks_cluster_capstone_appu"
  location            = azurerm_resource_group.appu-capstone-aks.location
  resource_group_name = azurerm_resource_group.appu-capstone-aks.name
  dns_prefix          = "appuAKSDnsPrefixv1"

  default_node_pool {
    name       = "agcapstaks"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}