# Resource-1: Create Azure Private DNS Zone
resource "azurerm_private_dns_zone" "private_dns_zone" {
  # name                = "${local.resource_name_prefix}-${var.mysql_db_name}.mysql.database.azure.com"
  name                = "hrdev.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-2: Associate Private DNS Zone to Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_vnet_associate" {
  depends_on = [ azurerm_subnet.dbsubnet ]
  name                  = "${local.resource_name_prefix}-private-dns-zone-vnet-associate"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# Resource-1: Azure MySQL Server
resource "azurerm_mysql_flexible_server" "mysql_server" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnet_associate]
  name                = "${local.resource_name_prefix}-${var.mysql_db_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_id          = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login  = var.mysql_db_username
  administrator_password = var.mysql_db_password
  delegated_subnet_id = azurerm_subnet.dbsubnet.id

  #sku_name   = "B_Gen5_2" # Basic Tier - Azure Virtual Network Rules not supported
  sku_name   = "GP_Standard_D2ds_v4" # General Purpose Tier - Supports Azure Virtual Network Rules
  version    = "8.0.21"
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  # public_network_access_enabled     = false
  # high_availability {
  #   mode                      = "ZoneRedundant"
  #   standby_availability_zone = "2"
  # }
  
}

# Resource-2: Azure MySQL Database / Schema
resource "azurerm_mysql_flexible_database" "webappdb" {
  name                = var.mysql_db_schema
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}


# Resource-3: Azure MySQL Firewall Rule - Allow access from Bastion Host Public IP
# resource "azurerm_mysql_firewall_rule" "mysql_fw_rule" {
#   name                = "allow-access-from-bastionhost-publicip"
#   resource_group_name = azurerm_resource_group.rg.name
#   server_name         = azurerm_mysql_flexible_server.mysql_server.name
#   # start_ip_address    =  azurerm_public_ip.bastion_host_publicip.ip_address # "151.227.72.12"
#   # end_ip_address      = azurerm_public_ip.bastion_host_publicip.ip_address # "151.227.72.12"
#   start_ip_address = "0.0.0.0"
#   end_ip_address = "0.0.0.0"
# }


# Resource-4: Azure MySQL Virtual Network Rule
# resource "azurerm_mysql_virtual_network_rule" "mysql_virtual_network_rule" {
#   name                = "mysql-vnet-rule"
#   resource_group_name = azurerm_resource_group.rg.name
#   server_name         = azurerm_mysql_flexible_server.mysql_server.name
#   subnet_id           = azurerm_subnet.websubnet.id
# }

