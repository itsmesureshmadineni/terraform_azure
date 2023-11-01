#business divison
variable "business_div" {
  description = "This is for which business divsion in this organization"
  type = string
  default = "finance"
}

#environment variables
variable "env_var" {
  description = "This is for environment varaibles"
  type = string
  default = "dev"
}

#resource group name
variable "resource_group_name" {
  description = "Mose used resource group"
  type = string
  default = "rg400suresh"
}

#location
variable "location" {
  description = "Location used in this resources"
  type = string
  default = "east US"
}