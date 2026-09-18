module "resource_group" {
  for_each = var.networks

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value.resource_group_name
  location = var.location
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
    }
  }
}