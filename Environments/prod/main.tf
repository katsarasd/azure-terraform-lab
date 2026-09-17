module "rg-con-hub" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-con-${var.environment}-${var.location_short}-01"
  location = var.location
}

module "rg-spoke01-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke01-${var.environment}-net-${var.location_short}-01"
  location = var.location
}

module "rg-spoke02-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke02-${var.environment}-net-${var.location_short}-net-01"
  location = var.location
}

module "rg-spoke03-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke03-${var.environment}-net-${var.location_short}-net-01"
  location = var.location

}