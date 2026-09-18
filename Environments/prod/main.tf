module "resource_group" {
  for_each = var.networks

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value.resource_group_name
  location = var.location
}

module "route_table" {
  for_each = local.subnets

  source  = "Azure/avm-res-network-routetable/azurerm"
  version = "~> 0.5"

  name = "rt-${each.value.subnet_key}-${each.value.network_key}-${var.environment}-${var.location_short}-01"

  location            = var.location
  resource_group_name = each.value.resource_group_name

  disable_bgp_route_propagation = false

  routes = each.value.routes

  depends_on = [
    module.resource_group
  ]
}

module "virtual_network" {
  for_each = var.networks

  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  parent_id = module.resource_group[each.key].resource_id

  name          = each.value.virtual_network_name
  location      = var.location
  address_space = each.value.address_space

  dns_servers = {
    dns_servers = var.dns_servers
  }

  subnets = {
    for subnet_key, subnet in each.value.subnets :
    subnet_key => {
      name                            = subnet.name
      address_prefixes                = subnet.address_prefixes
      default_outbound_access_enabled = subnet.default_outbound_access_enabled

      route_table = {
        id = module.route_table["${each.key}.${subnet_key}"].resource_id
      }
    }
  }

  depends_on = [
    module.route_table
  ]
}