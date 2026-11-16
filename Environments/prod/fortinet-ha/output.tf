output "ResourceGroup" {
  value = var.resource_group_name
}

output "ActiveMGMTPublicIP" {
  value = format(
    "https://%s:%s",
    azurerm_public_ip.ActiveMGMTIP.ip_address,
    var.adminsport
  )
}

output "PassiveMGMTPublicIP" {
  value = format(
    "https://%s:%s",
    azurerm_public_ip.PassiveMGMTIP.ip_address,
    var.adminsport
  )
}
output "ExternalLBPublicIP" {
    value = azurerm_public_ip.external_lb_public_ip.ip_address
}

output "ExternalLBID" {
    value = azurerm_lb.external_lb.id
}

output "InternalLBFrontendIP" {
    value = var.internal_lb_frontend_ip
}

output "InternalLBID" {
    value = azurerm_lb.internal_lb.id
}
output "Username" {
  value = var.adminusername
}

output "Password" {
  value     = var.adminpassword
  sensitive = true
}