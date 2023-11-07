#resource group creation
resource "azurerm_resource_group" "rg_name" {
  name = "${local.prefex}-${var.resource_group}"
  location = var.location

  tags = local.common_tags
}