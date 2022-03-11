# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "master" {
    name                = "master_nsg"
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    security_rule {
        name                       = "IngressController"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = var.ingress_controller_port
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    tags = var.tags
}

resource "azurerm_network_security_group" "workers" {
    name                = "workers_nsg"
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "master" {
    network_interface_id      = azurerm_network_interface.master.id
    network_security_group_id = azurerm_network_security_group.master.id
}

resource "azurerm_network_interface_security_group_association" "workers" {
    network_interface_id      = azurerm_network_interface.workers[count.index].id
    count                     = var.workers_count
    network_security_group_id = azurerm_network_security_group.workers.id
}