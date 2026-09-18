module "resource_groups" {
  for_each = var.networks

  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.4.0"

  name     = each.value.resource_group_name
  location = var.location
}

module "virtual_networks" {
  for_each = var.networks

  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.22.2"

  parent_id = module.resource_groups[each.key].resource_id

  name          = each.value.vnet_name
  location      = var.location
  address_space = each.value.address_space

  dns_servers = {
    dns_servers = var.dns_servers
  }

  subnets = each.value.subnets

  depends_on = [
    module.resource_groups
  ]
}