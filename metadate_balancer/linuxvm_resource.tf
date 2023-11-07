#Create a resource of virtual vm
resource "azurerm_linux_virtual_machine" "linuxvm_vm" {
  count = var.vm_count
  name = "${local.prefex}-linuxvm-${count.index}"
  computer_name = "suresh-linuxvm"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  size = "Standard_B2s"
  admin_username = var.username
  network_interface_ids = [ element(azurerm_network_interface.web_linuxvn_ni[*].id, count.index) ]

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
  
  custom_data = filebase64("${path.module}/scripts/linux_sw.sh")     #this is for files to encrypted
  #custom_data = base64decode(local.linuxvm_custom_data)
  tags = local.common_tags
}


