module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-con-${var.environment}-${var.location_short}-01"
  location = var.location
}

module "virtual_network" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  name                = "vnet-con-${var.environment}-${var.location_short}-01"
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = [
    "10.10.0.0/16"
  ]
}