#creation fo virstual network
resource "azurerm_virtual_network" "vnet" {
  name = "${local.prefex}-${var.vnet_name}"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  address_space = var.vnet_address

  tags = local.common_tags
}