data "terraform_remote_state" "eastus" {
  backend = "azurerm"
  config = {
    resource_group_name = "rg400"
    storage_account_name = "tfstatefilesuresh"
    container_name = "statefiles"
    key = "eastus-terraform.tfstate"
  }
}

data "terraform_remote_state" "centralus" {
  backend = "azurerm"
  config = {
    resource_group_name = "rg400"
    storage_account_name = "tfstatefilesuresh"
    container_name = "statefiles"
    key = "centralus-terraform.tfstate"
  }
}