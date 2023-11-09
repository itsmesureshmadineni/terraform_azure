#Create the vnet,app,web,db and bastion hosts inputs

#create vnet name
variable "vnet_name" {
  description = "This is the virtual network name"
  type = string
  default = "vnet"
}

#create vnet adress spce
variable "vnet_address" {
  description = "This is for vnet address space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

#create app subnet name
variable "app_subnet_name" {
  description = "This is the virtual network app subnet name"
  type = string
  default = "appsubnet"
}

#create app subnet adress spce
variable "app_subnet_address" {
  description = "This is for vnet app subnet address space"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

#create db subnet name
variable "db_subnet_name" {
  description = "This is the virtual network db subnet name"
  type = string
  default = "dbsubnet"
}

#create db subnet address spce
variable "db_subnet_address" {
  description = "This is for vnet db subnet address space"
  type = list(string)
  default = [ "10.0.20.0/24" ]
}

#create web subnet name
variable "web_subnet_name" {
  description = "This is the virtual network web subnet name"
  type = string
  default = "websubnet"
}

#create web subnet address spce
variable "web_subnet_address" {
  description = "This is for vnet web subnet address space"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

#create bastion host subnet name
variable "bastion_subnet_name" {
  description = "This is the virtual network bastion subnet name"
  type = string
  default = "bastionsubnet"
}

#create bastion host address spce
variable "bastion_subnet_address" {
  description = "This is for vnet bastion subnet address space"
  type = list(string)
  default = [ "10.0.100.0/24" ]
}