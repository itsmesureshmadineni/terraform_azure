#creation of web subnet
resource "azurerm_subnet" "websubnet" {
  name = var.web_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.web_subnet_address
  resource_group_name = azurerm_resource_group.rg_name.name
}

#create a network security group
resource "azurerm_network_security_group" "web_nsg" {
  name = "${azurerm_subnet.websubnet.name}-nsg"
  location = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name
}

#associate nsg and subnet
resource "azurerm_subnet_network_security_group_association" "websunetnsg" {
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

locals {
  websubnet_nsg_rules = {
    "100" : "22",
    "101" : "80"
  }
}

#creation of nsg rules
resource "azurerm_network_security_rule" "webnsgrule" {
  for_each = local.websubnet_nsg_rules
  
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
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}
