# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file

resource "local_file" "ansible_inventory" {
    filename = "${path.module}/../ansible/host.azure"
    
    # https://www.terraform.io/language/functions/templatefile
    
    content  = templatefile("${path.module}/ansible-inventory.tftpl",
        {
            user       = var.ssh_user
            master_ip  = azurerm_linux_virtual_machine.master.public_ip_address
            worker_ips = toset([for worker_vm in azurerm_linux_virtual_machine.workers : worker_vm.public_ip_address])
        }
    )
}

# https://www.terraform.io/language/resources/provisioners/null_resource

resource "null_resource" "ansible_run" {
    
    # https://www.terraform.io/language/meta-arguments/depends_on
    
    depends_on = [
        azurerm_linux_virtual_machine.master,
        azurerm_linux_virtual_machine.workers,
    ]
    
    # https://www.terraform.io/language/resources/provisioners/local-exec
    
    provisioner "local-exec" {
        working_dir = "${path.module}/../ansible/" 
        command     = "ansible-playbook -i host.azure --private-key ${var.private_key_path} deploy.yml"
    }
}

# https://learn.hashicorp.com/tutorials/terraform/outputs

output "URL" {
    description = "URL access to application"
    value       = "http://${azurerm_linux_virtual_machine.master.public_ip_address}"
}
