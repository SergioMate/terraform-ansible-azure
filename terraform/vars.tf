# https://www.terraform.io/language/values/variables

variable "workers_count" {
    description = "workers count"
    type        = number
    default     = 2
}

variable "tags" {
    description = "All resources tag"
    type        = map(string)
    default     = {
        environment = "CP2"
    }
}

# https://docs.microsoft.com/en-us/azure/virtual-machines/sizes
# https://azureprice.net/

variable "master_vm_size" {
    description = "master VM size"
    type        = string
    default     = "Standard_A2m_v2" # 2 vCPU & 16 GB
}

# https://github.com/Azure/k8s-best-practices/blob/master/Cost_Optimization.md#worker---vm-sizes

variable "worker_vm_size" {
    description = "worker VM size"
    type        = string
    default     = "Standard_DS11-1_v2" # 1 vCPU & 14 GB
}

variable "private_key_path" {
    type        = string
    description = "Ruta para la clave privada de acceso a las instancias"
    default     = "~/.ssh/id_rsa"
}

variable "ingress_controller_port" {
    description = "ingress controller port"
    type        = number
    default     = 30153
}