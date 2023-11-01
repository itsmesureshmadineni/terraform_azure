#Variables for linux virtaul machine 
variable "vm_name" {
  description = "Virtual machine name"
  type = string
  default = "linux_vm"
}

variable "username" {
  description = "Username for virtual vm"
  type = string
  default = "azureuser"
}
