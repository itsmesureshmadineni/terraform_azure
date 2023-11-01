#Local block for custom data
locals {
  linuxvm_custom_data = <<CUSTOM_DATA
  #!/bin/bash
  sudo apt-get update -y
  sudo apt install -y apache2
  sudo echo "<h1> this is created from custom script </h1>" >> /var/www/html/index.html
  CUSTOM_DATA
}

#Create a resource of virtual vm
resource "azurerm_linux_virtual_machine" "linuxvm_vm" {
  name = "${local.prefix}-${var.vm_name}"
  computer_name = "suresh_${var.vm_name}"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  size = "Standard_F2"
  admin_username = var.username
  network_interface_ids = [ azurerm_network_interface.azurerm_network_interface.myni.id ]

  admin_ssh_key {
    username = var.username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts-gen2"
    version = "latest"
  }
  
  #custom_data = filebase64("${path.module}/scripts/linux_sw.sh")     #this is for files to encrypted
  custom_data = base64decode(local.linuxvm_custom_data)
  tags = local.common_tags
}


