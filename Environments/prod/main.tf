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

  name     = "rg-spoke02-${var.environment}-net-${var.location_short}-01"
  location = var.location
}

module "rg-spoke03-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-spoke03-${var.environment}-net-${var.location_short}-01"
  location = var.location

}

module "hub-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-con-hub.resource_id 
  name                = "vnet-con-${var.environment}-${var.location_short}-01"
  location            = var.location
  address_space = var.address_space_hub-vnet
}

module "spoke01-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-spoke01-net.resource_id 
  name                = "vnet-spoke01-${var.environment}-${var.location_short}-01"
  location            = var.location
  address_space = var.address_space_spoke01-vnet

  subnets = {
    subnet0 = {
      name                            = "snet-dc-spoke01-${var.environment}"
      default_outbound_access_enabled = false
      address_prefixes = ["10.126.16.0/28"]
    }
    subnet1 = {
      name                            = "snet-ca-spoke01-${var.environment}"
      address_prefixes                = ["10.126.16.16/28"]
      default_outbound_access_enabled = false
    
  }
  subnet2 = {
      name                            = "snet-pki-spoke01-${var.environment}"
      address_prefixes                = ["10.126.16.32/28"]
      default_outbound_access_enabled = false
    
  }
}
}

module "spoke02-vnet" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  parent_id = module.rg-spoke02-net.resource_id 
  name                = "vnet-spoke02-${var.environment}-${var.location_short}-01"
  location            = var.location
  address_space = var.address_space_spoke02-vnet

  subnets = {
    subnet0 = {
      name                            = "snet-app-spoke02-${var.environment}"
      address_prefixes = ["10.126.32.0/24"]
      default_outbound_access_enabled = false
    }
    subnet1 = {
      name                            = "snet-sql-spoke02-${var.environment}"
      address_prefixes                = ["10.126.33.0/24"]
      default_outbound_access_enabled = false
    
  }
  subnet2 = {
      name                            = "snet-pe-spoke02-${var.environment}"
      address_prefixes                = ["10.126.34.0/27"]
      default_outbound_access_enabled = false
    
  }
}
}
