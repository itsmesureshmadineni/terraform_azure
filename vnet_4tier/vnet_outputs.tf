#creation of vnet  output variables 
#virtauls network name 
output "vnet_name" {
  description = "Vnet name"
  value = azurerm_virtual_network.myvnet.name
}

#virtual network ID
output "vnet_id" {
  value = azurerm_virtual_network.myvnet.id
}
#creation of subnet outputs
#web subnet name
output "websubnet_name" {
  value = azurerm_subnet.websubnet.name
}
#web subnet id
output "websubnet_id" {
  value = azurerm_subnet.websubnet.id
}
