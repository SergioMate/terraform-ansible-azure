variable "location" {
    type        = string
    description = "Región de Azure donde creamos la infraestructura"
    default     = "West Europe"
}

variable "storage_account" {
    type        = string
    description = "Nombre para la storage account"
    default     = "staccountcp2smc"
}

variable "public_key_path" {
    type        = string
    description = "Ruta para la clave pública de acceso a las instancias"
    default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
    type        = string
    description = "Ruta para la clave privada de acceso a las instancias"
    default     = "~/.ssh/id_rsa"
}

variable "ssh_user" {
    type        = string
    description = "Usuario para hacer ssh"
    default     = "adminUsername"
}