#public IP address for virtaul machine
resource "azurerm_public_ip" "myip" {
  name = "${local.prefix}-mypublicip"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  sku = "Standard"
  domain_name_label = "app1-vm-suresh"

  tags = local.common_tags
}