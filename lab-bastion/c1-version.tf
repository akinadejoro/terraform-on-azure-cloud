# Terraform Block
terraform {
    required_version = ">=1.0.0"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.8"
      }
      random = {
      source = "hashicorp/random"
      version = ">= 3.5"
      }
    }
}

# Provider Block
provider "azurerm" {
  features {}
}