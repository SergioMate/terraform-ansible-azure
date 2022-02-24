# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file

resource "local_file" "ansible_inventory" {
    filename = "${path.module}/../ansible/host.azure"
    
    # https://www.terraform.io/language/functions/templatefile
    
    content  = templatefile("${path.module}/inventory.tftpl",
        {
            user     = var.ssh_user
            master_ip  = azurerm_linux_virtual_machine.master.public_ip_address,
            worker_ips = toset([for worker_vm in azurerm_linux_virtual_machine.workers : worker_vm.public_ip_address])
        }
    )    
}