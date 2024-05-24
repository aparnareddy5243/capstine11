terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name   = "ap_rg1"
    storage_account_name  = "terraform524"
    container_name        = "container52"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "appu_aks_rg1" { # Declaring resource group here
  name     = "appu_aks_rg1"
  location = "UK South"
}

resource "azurerm_kubernetes_cluster" "appu_aks11" {
  name                = "appu_aks1"
  location            = azurerm_resource_group.appu_aks_rg1.location # Referencing the declared resource group
  resource_group_name = azurerm_resource_group.appu_aks_rg1.name      # Referencing the declared resource group
  dns_prefix          = "appu-aks111"

  default_node_pool {
    name       = "appupool"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "appu11" {
  name                  = "appu11"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.appu_aks11.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "test1"
  }
}