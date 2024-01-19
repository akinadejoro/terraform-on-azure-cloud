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
# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "akterraformstore"
    container_name        = "tfstatefiles"
    key                   = "project-3-traffic-manager-terraform.tfstate"
  }   
}

# Provider Block
provider "azurerm" {
 features {}          
}


