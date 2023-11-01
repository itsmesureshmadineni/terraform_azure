#create network interface for the linux vm
resource "azurerm_network_interface" "myni" {
  name = "${local.prefix}-network-interface"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location

  ip_configuration {
    name = "web-linuxvm_ip1"
    subnet_id = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.myip.id
  }

}