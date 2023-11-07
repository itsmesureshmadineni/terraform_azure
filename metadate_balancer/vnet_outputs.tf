#Outputs of virtaual network
output "virtaul_network" {
  description = "This is virtaul network name"
  value = azurerm_virtual_network.vnet.name
}

output "websubnet" {
  value = azurerm_subnet.websubnet.name
}