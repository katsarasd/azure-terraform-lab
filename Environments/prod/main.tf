resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-${var.location_short}-01"
  location = var.location
}

