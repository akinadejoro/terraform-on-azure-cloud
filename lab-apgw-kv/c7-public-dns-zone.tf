# Datasource: Get DNS Record
data "azurerm_dns_zone" "dns_zone" {
  name                = "aklab.work"
  resource_group_name = "dns-zones"
}

# Resource-1: Add ROOT Record Set in DNS Zone
resource "azurerm_dns_a_record" "dns_record" {
  depends_on = [azurerm_public_ip.web_ag_publicip]
  name                = "@"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.web_ag_publicip.id
}

# Resource-2: Add www Record Set in DNS Zone
resource "azurerm_dns_a_record" "dns_record_www" {
  depends_on = [azurerm_public_ip.web_ag_publicip]  
  name                = "www"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.web_ag_publicip.id
}

# Resource-3: Add app1 Record Set in DNS Zone
# resource "azurerm_dns_a_record" "dns_record_app1" {
#   depends_on = [azurerm_public_ip.web_ag_publicip]
#   name                = "app1"
#   zone_name           = data.azurerm_dns_zone.dns_zone.name
#   resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
#   ttl                 = 300
#   target_resource_id  = azurerm_public_ip.web_ag_publicip.id
# }
