# Resource-1: Traffic Manager Profile
resource "azurerm_traffic_manager_profile" "tm_profile" {
  name                   = "mytfdemo-${random_string.myrandom.id}"
  resource_group_name    = azurerm_resource_group.rg.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = "mytfdemo-${random_string.myrandom.id}"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
  
  tags = local.common_tags
}

# Traffic Manager Endpoint - Project-1-EastUs2
resource "azurerm_traffic_manager_azure_endpoint" "tm_endpoint_project1_uksouth" {
  name                = "tm-endpoint-project1-uksouth"
  profile_id          = azurerm_traffic_manager_profile.tm_profile.id
  target_resource_id  = data.terraform_remote_state.project1_uksouth.outputs.web_lb_public_ip_address_id
  weight              = 50
}


# Traffic Manager Endpoint - Project-2-WestUs2
resource "azurerm_traffic_manager_azure_endpoint" "tm_endpoint_project2_ukwest" {
  name                = "tm-endpoint-project2-ukwest"
  profile_id          = azurerm_traffic_manager_profile.tm_profile.id
  target_resource_id  = data.terraform_remote_state.project2_ukwest.outputs.web_lb_public_ip_address_id 
  weight              = 50
}
