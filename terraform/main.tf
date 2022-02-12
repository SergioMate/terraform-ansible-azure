# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=2.46.1"
        }
    }
}

provider "azurerm" {
    features {}
    subscription_id = "<SUBSCRIPTION-ID>"
    client_id       = "<APP-ID>"
    client_secret   = "<PASSWORD>"
    tenant_id       = "<TENANT>"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "rg" {
    name     = "kubernetes_rg"
    location = vars.location
  
    tags = {
        environment = "CP2"
    }
  
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "stAccount" {
    name                     = "staccountcp2"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }
    
}