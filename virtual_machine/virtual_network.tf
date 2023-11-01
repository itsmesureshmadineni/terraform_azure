#create virtual network
resource "azurerm_virtual_network" "myvnet" {
  name = "${local.prefix}-${var.vnet_name}"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space = [ "10.0.0.0/16" ]
  tags = local.common_tags
}
