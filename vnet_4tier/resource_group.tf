#creating a resource group
resource "azurerm_resource_group" "myrg" {
  name = "${local.prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.location
  tags = local.common_tags
}