resource "azurerm_resource_group" "rgname" {
  name = "${var.location}-${var.rg_name}"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name = "${var.location}-${var.vnet_name}"
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name
}

resource "azurerm_subnet" "vnet_subnet" {
  name = "subnet-internal"
  address_prefixes = [ "10.0.2.0/24" ]
  resource_group_name = azurerm_resource_group.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_interface" "vnet_ni" {
  name = "${var.location}-ni"
  location = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name

  ip_configuration {
    name = "${var.location}-ipconfig"
    subnet_id = azurerm_subnet.vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.location}-vm"
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
}