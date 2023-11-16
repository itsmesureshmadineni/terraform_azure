resource "azurerm_resource_group" "rgname" {
  name = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name = "${var.rg_name}${var.vnet_name}"
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name
}

resource "azurerm_subnet" "vnet_subnet" {
  name = "subnetinternal"
  address_prefixes = [ "10.0.2.0/24" ]
  resource_group_name = azurerm_resource_group.rgname.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "myip" {
  name = "mypublicip"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.rgname.name
  location = azurerm_resource_group.rgname.location
  sku = "Standard"
}

resource "azurerm_network_security_group" "mynsg" {
  name = "nsg"
  location = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name
}

#associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "websunet_nsg_association" {
  depends_on = [ azurerm_network_security_rule.web_subnet_rule ]
  network_security_group_id = azurerm_network_security_group.mynsg.id
  subnet_id = azurerm_subnet.vnet_subnet.id
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
  name                        = "nsg-rules-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rgname.name
  network_security_group_name = azurerm_network_security_group.mynsg.name
}

resource "azurerm_network_interface" "vnet_ni" {
  name = "${var.rg_name}ni"
  location = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name

  ip_configuration {
    name = "${var.rg_name}ipconfig"
    subnet_id = azurerm_subnet.vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.myip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.rg_name}vm"
  resource_group_name = azurerm_resource_group.rgname.name
  location            = azurerm_resource_group.rgname.location
  size                = "Standard_F2"
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.vnet_ni.id
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/scripts/linux_sw.sh")
}