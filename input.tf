// Crear las maquinas virtuales
variable "vm_names_create" {
  type    = list(string)
  default = ["vm02"]  # Actualiza con los nombres de las máquinas virtuales deseadas
}

variable "subnet_names_create" {
  type    = list(string)
  default = ["default"]  # Actualiza con los nombres de las subredes deseadas
}

variable "existing_images" {
  type    = list(string)
  default = ["template1"]
}

variable "tags" {
  description = "Etiquetas para las instancias"
  type        = map(string)
  default     = {
    key1      = "value1"
    key2     = "redhat"
    key3    = "template1"
  }
}

variable "admin_password" {
  description = "La contraseña admin"
  type        = string
  sensitive   = true
}