module "rg-con-hub" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-con-${var.environment}-${var.location_short}-01"
  location = var.location
}
module "rg-spoke01-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke01-${var.environment}-${var.location_short}-net-01"
  location = var.location
}

module "rg-spoke02-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke02-${var.environment}-${var.location_short}-net-01"
  location = var.location
}

module "rg-spoke03-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke03-${var.environment}-${var.location_short}-net-01"
  location = var.location

}
module "hub-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-con-hub.resource_id 
  name                = "vnet-con-${var.environment}-${var.location_short}-01"
  location            = var.location

  address_space = [
    "10.216.0.0/20"
  ]
}

module "spoke01-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-spoke01-net.resource_id 
  name                = "vnet-spoke01-${var.environment}-${var.location_short}-01"
  location            = var.location

  address_space = [
    "10.216.16.0/20"
  ]
}

module "spoke02-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-spoke02-net.resource_id 
  name                = "vnet-spoke02-${var.environment}-${var.location_short}-01"
  location            = var.location

  address_space = [
    "10.216.32.0/20"
  ]
}

module "spoke03-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-spoke03-net.resource_id 
  name                = "vnet-spoke03-${var.environment}-${var.location_short}-01"
  location            = var.location

  address_space = [
    "10.216.48.0/20"
  ]
}
