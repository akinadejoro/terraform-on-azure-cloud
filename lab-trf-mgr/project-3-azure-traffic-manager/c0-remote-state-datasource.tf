# Project-1: East US2 Datasource
data "terraform_remote_state" "project1_uksouth" {
  backend = "azurerm"
  config = {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "akterraformstore"
    container_name        = "tfstatefiles"
    key                   = "project-1-uksouth-terraform.tfstate"
  }
}

# Project-2: West US2 Datasource
data "terraform_remote_state" "project2_ukwest" {
  backend = "azurerm"
  config = {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "akterraformstore"
    container_name        = "tfstatefiles"
    key                   = "project-2-ukwest-terraform.tfstate"
  }
}

/* 
1. Project-1: Web LB Public IP Address
data.terraform_remote_state.project1_eastus2.outputs.web_lb_public_ip_address_id
1. Project-2: Web LB Public IP Address
data.terraform_remote_state.project2_westus2.outputs.web_lb_public_ip_address_id
*/