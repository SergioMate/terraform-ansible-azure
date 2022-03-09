# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "cp2" {
    name                = "cp2_net"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    
    tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "cp2" {
    name                 = "cp2_subnet"
    resource_group_name  = azurerm_resource_group.cp2.name
    virtual_network_name = azurerm_virtual_network.cp2.name
    address_prefixes     = ["10.0.1.0/24"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "master" {
    name                = "master_ip"
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    allocation_method   = "Dynamic"
    sku                 = "Basic"
    
    tags = var.tags
}

resource "azurerm_public_ip" "workers" {
    name                = "worker${count.index}_ip"
    count               = var.workers_count
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    allocation_method   = "Dynamic"
    sku                 = "Basic"
    
    tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "master" {
    name                = "master_nic"
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    
    ip_configuration {
        name                          = "master_ipconf"
        subnet_id                     = azurerm_subnet.cp2.id
        private_ip_address_allocation = "Static"
        private_ip_address_allocation = "10.0.1.10"
        public_ip_address_id          = azurerm_public_ip.master.id
    }
    
    tags = var.tags
}

resource "azurerm_network_interface" "workers" {
    name                = "workers${count.index}_nic"
    count               = var.workers_count
    location            = azurerm_resource_group.cp2.location
    resource_group_name = azurerm_resource_group.cp2.name
    
    ip_configuration {
        name                          = "workers${count.index}_ipconf"
        subnet_id                     = azurerm_subnet.cp2.id
        private_ip_address_allocation = "Static"
        private_ip_address_allocation = "10.0.1.${11 + count.index}"
        public_ip_address_id          = azurerm_public_ip.workers[count.index].id
    }
    
    tags = var.tags
}