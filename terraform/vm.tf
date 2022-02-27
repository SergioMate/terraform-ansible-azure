# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "master" {
    name                            = "master"
    resource_group_name             = azurerm_resource_group.cp2.name
    location                        = azurerm_resource_group.cp2.location
    size                            = var.master_vm_size
    admin_username                  = var.ssh_user
    network_interface_ids           = [ azurerm_network_interface.master.id ]
    disable_password_authentication = true
    
    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }
    
    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }
    
    boot_diagnostics {
        # https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
        
        storage_account_uri = azurerm_storage_account.cp2.primary_blob_endpoint
    }
    
    # https://www.terraform.io/language/resources/provisioners/remote-exec
    
    provisioner "remote-exec" {
        inline = ["echo '${self.name} ready for SSH'"]
        
        connection {
            type        = "ssh"
            host        = self.public_ip_address
            user        = var.ssh_user
            private_key = file(var.private_key_path)
        }
    }
    
    tags = var.tags 
}

resource "azurerm_linux_virtual_machine" "workers" {
    name                             = "worker${count.index}"
    resource_group_name              = azurerm_resource_group.cp2.name
    location                         = azurerm_resource_group.cp2.location
    size                             = var.worker_vm_size
    admin_username                   = var.ssh_user
    count                            = var.workers_count
    network_interface_ids            = [ azurerm_network_interface.workers[count.index].id ]
    disable_password_authentication  = true
    
    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }
    
    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }
    
    boot_diagnostics {
        # https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
        
        storage_account_uri = azurerm_storage_account.cp2.primary_blob_endpoint
    }
    
    # https://www.terraform.io/language/resources/provisioners/remote-exec
    
    provisioner "remote-exec" {
        inline = ["echo '${self.name} ready for SSH'"]
        
        connection {
            type        = "ssh"
            host        = self.public_ip_address
            user        = var.ssh_user
            private_key = file(var.private_key_path)
        }
    }
    
    tags = var.tags 
}