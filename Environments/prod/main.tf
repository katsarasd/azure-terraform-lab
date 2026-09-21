module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"

  location = var.location
  name     = local.resource_names.resource_group_name

}

module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.14.1"

  parent_id           = module.resource_group.resource_id
  subnets             = local.subnets
  address_space       = [var.address_space]
  location            = var.location
  name                = local.resource_names.virtual_network_name
 
}

module "network_security_group" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.0"

  resource_group_name = module.resource_group.name
  name                = local.resource_names.network_security_group_name
  location            = var.location

  security_rules = {
    no_internet = {
      access                     = "Deny"
      direction                  = "Outbound"
      name                       = "block-internet-traffic"
      priority                   = 100
      protocol                   = "*"
      destination_address_prefix = "Internet"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
  }

  
}

