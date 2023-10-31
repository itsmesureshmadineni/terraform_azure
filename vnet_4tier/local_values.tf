#local values
locals {
  owner = var.business_div
  env = var.env_var
  prefix = "${var.business_div}-${var.env_var}"
  
  common_tags = {
    owner = local.owner,
    env = local.env
  }
}