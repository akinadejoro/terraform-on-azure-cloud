# Output Values
output "mysql_server_fqdn" {
  description = "MySQL Server FQDN"
  value = azurerm_private_dns_zone.private_dns_zone.name
}

output "mysql_server_fqdn_name" {
  description = "MySQL Server FQDN Output"
  value = azurerm_mysql_flexible_server.mysql_server.fqdn
}

output "mysql_server_public_access" {
  description = "Is the public network access enabled?"
  value = azurerm_mysql_flexible_server.mysql_server.public_network_access_enabled
}