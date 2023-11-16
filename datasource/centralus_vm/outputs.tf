output "rgroup_name" {
  value = azurerm_resource_group.rgname.name
}

output "rg_location" {
  value = azurerm_resource_group.rgname.location
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}