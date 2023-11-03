#local variables
locals {
  team = var.team
  owner = var.owner
  prefex = "${var.owner}-${var.team}"

  common_tags = {
    owner = local.owner
    team = local.team
  }
}