#outputs of linux vm
output "linuxvm_vm_name" {
  value = azurerm_linux_virtual_machine.linuxvm_vm.id
}

output "linuxvm_ni_private" {
  value = azurerm_network_interface.myni.private_ip_address
}

output "linuxvm_public_ni" {
  value = azurerm_network_interface.myni.ip_configuration
}