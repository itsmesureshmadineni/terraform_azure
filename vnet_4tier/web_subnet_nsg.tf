#create web subnet 
resource "azurerm_subnet" "websubnet" {
  name = var.web_subnet_name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes = var.web_subnet_address
  resource_group_name = azurerm_resource_group.myrg.name
}

#create NSG network security group
resource "azurerm_network_security_group" "mynsg" {
  name = "${azurerm_subnet.websubnet.name}-nsg"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

#associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "websunet_nsg_association" {
  depends_on = [ azurerm_network_security_rule.web_subnet_rule ]
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id = azurerm_subnet.websubnet.id
}

#creation of NSG rules
#local block for security rules
locals {
  web_subnet_inbound_ports = {
    "100" : "22"
    "101" : "80"
    "102" : "443"
    "105" : "8080"
  }
}
#NSG inbound rules for web subnet

resource "azurerm_network_security_rule" "web_subnet_rule" {
  for_each = local.web_subnet_inbound_ports
  name                        = "nsg_rules-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.mynsg.name
}