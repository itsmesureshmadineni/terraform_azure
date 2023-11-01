#Network security group NSG for linuxvm
resource "azurerm_network_security_group" "linuxvmnsg" {
  name = "${local.prefix}-linuxvm_nsg"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

#Associate NSG to linuxvm NIC
resource "azurerm_network_interface_security_group_association" "nsgasscialtion" {
  depends_on = [ azurerm_network_security_rule.nsgrule_linuxvm ]
  network_interface_id = azurerm_network_interface.myni.id
  network_security_group_id = azurerm_network_security_group.linuxvmnsg.id
}

#NSG rules
locals {
  linuxvm_nsg_ports = {
    "115" : "80",
    "116" : "22"
  }
}

resource "azurerm_network_security_rule" "nsgrule_linuxvm" {
  for_each = local.linuxvm_nsg_ports
  name                        = "nsg_linux_rules-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.linuxvmnsg.name
}