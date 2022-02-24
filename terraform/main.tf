# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=2.46.1"
        }
        local = {
            source = "hashicorp/local"
        }
    }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "cp2" {
    name     = "resourcegroup_cp2"
    location = var.location
  
    tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "cp2" {
    name                     = var.storage_account
    resource_group_name      = azurerm_resource_group.cp2.name
    location                 = azurerm_resource_group.cp2.location
    account_tier             = "Standard"
    
    # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    
    account_replication_type = "LRS"

    tags = var.tags
}