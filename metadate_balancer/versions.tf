#Terraform version and providers
terraform {
  required_version = ">= 1.5.0"
  #providers version
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