resource "azurerm_resource_group" "imagerg" {
  name     = "imagerg"
  location = "West Europe"
}

resource "azurerm_image" "imagevm" {
  name                      = "imagevm-centralus"
  location                  = "West US"
  resource_group_name       = azurerm_resource_group.imagerg.name
  source_virtual_machine_id = data.terraform_remote_state.centralus.outputs.vm_name
}