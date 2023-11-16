terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.0.0"
    }
  }

  #terraform state file in backend
  backend "azurerm" {
    resource_group_name = "rg400"
    storage_account_name = "tfstatefilesuresh"
    container_name = "statefiles"
    key = "eastus-terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
  alias = "east-us-1"
  
}