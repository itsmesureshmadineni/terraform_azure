#create a bastion host subnet
resource "azurerm_subnet" "bastion_subnet" {
  name = var.bastion_subnet_name
  resource_group_name = azurerm_resource_group.rg_name.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_subnet_address
}

#creation of NSG for bastion subnet
resource "azurerm_network_security_group" "bastion_nsg" {
  name = "${azurerm_subnet.bastion_subnet.name}-nsg"
  location = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name
}

#association NSG with bastion subnet
resource "azurerm_subnet_network_security_group_association" "bastionnsgasso" {
  depends_on = [ azurerm_network_security_rule.bastionnsgrule ]
  subnet_id = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}

#local varialble for ports
locals {
  bastion_nsg_ports = {
    "200" : "22",
    "201" : "80"
  }
}

#security rule
resource "azurerm_network_security_rule" "bastionnsgrule" {
  for_each = local.bastion_nsg_ports
  
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_name.name
  network_security_group_name = azurerm_network_security_group.bastion_nsg.name
}