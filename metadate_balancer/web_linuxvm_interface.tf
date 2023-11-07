#resource creation for web linux vm netwrok interface
resource "azurerm_network_interface" "web_linuxvn_ni" {
  count = var.vm_count
  name = "web-linuxvm-nw-interface-${count.index}"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  
  ip_configuration {
    name = "web-linuxvm-ipconfig"
    subnet_id = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}