#create virtual network
resource "azurerm_virtual_network" "myvnet" {
  name = "${local.prefix}-${var.vnet_name}"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space = var.vnet_address
  tags = local.common_tags
}
