module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-con-${var.environment}-${var.location_short}-01"
  location = var.location
}

module "virtual_network" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.resource_group.resource_id 
  name                = "vnet-con-${var.environment}-${var.location_short}-01"
  location            = var.location

  address_space = [
    "10.10.0.0/16"
  ]
}