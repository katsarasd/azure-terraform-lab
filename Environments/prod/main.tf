module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value
  location = var.location
}

module "network_security_group" {
  for_each = local.nsgs

  source = "Azure/avm-res-network-networksecuritygroup/azurerm"

  name                = local.nsg_names[each.key]
  location            = var.location
  resource_group_name = module.resource_group[each.value.resource_group].name
}

module "virtual_network" {
  for_each = var.vnets

  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  name      = local.vnet_names[each.key]
  location  = var.location
  parent_id = module.resource_group[each.value.resource_group].resource_id

  address_space = each.value.address_space

  dns_servers = {
    dns_servers = var.dns_servers
  }

  subnets = {
    for subnet_key, subnet in each.value.subnets :
    subnet_key => {
      name = local.subnet_names["${each.key}-${subnet_key}"]

      address_prefixes = subnet.address_prefixes

      network_security_group = subnet.nsg_enabled ? {
        id = module.network_security_group[
          "${each.key}-${subnet_key}"
        ].resource_id
      } : null
    }
  }
}