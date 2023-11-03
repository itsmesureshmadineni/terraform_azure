#Input variables for virtual network
variable "vnet_name" {
  description = "Virtaul network name"
  type = string
  default = "vnet-lb"
}

variable "vnet_address" {
  description = "Address prefix for virtaul network"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

variable "web_subnet_name" {
  description = "web subnet name"
  type = string
  default = "web-subnet"
}

variable "web_subnet_address" {
  description = "Address prefix for web subnet"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "bastion_subnet_name" {
  description = "bastion subnet name"
  type = string
  default = "bastionsubnet"
}

variable "bastion_subnet_address" {
  description = "Address prefix for bastion subnet"
  type = list(string)
  default = [ "10.0.100.0/24" ]
}
