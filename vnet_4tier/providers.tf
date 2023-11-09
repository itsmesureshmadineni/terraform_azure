#Terrform cli version and providers version
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.0.0"
    }
  }
}

#providers
provider "azurerm" {
  features {}
}
