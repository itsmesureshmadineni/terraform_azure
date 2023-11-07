#genric variables
variable "location" {
  description = "Location variable"
  type = string
  default = "east US"
}

variable "resource_group" {
  description = "Resource group name"
  type = string
  default = "resource-group-load-balncer"
}

variable "team" {
  description = "Devlopment team name"
  type = string
  default = "dev"
}

variable "owner" {
  description = "Organisation name"
  type = string
  default = "walmart"
}

variable "username" {
  description = "Username for virtual vm"
  type = string
  default = "azureuser"
}

variable "vm_count" {
  description = "Count of the virtual machines"
  type = number
  default = 2
}

variable "nic_inbound_ports" {
  description = "NAT inbound ports list"
  type = list(string)
  default = [ "1022", "2022" ]
}