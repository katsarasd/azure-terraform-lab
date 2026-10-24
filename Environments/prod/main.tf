module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value
  location = var.location
}

module "virtual_network" {
  for_each = var.vnets

  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  name     = local.vnet_names[each.key]
  location = var.location
  parent_id = module.resource_group[each.value.resource_group].resource_id
  address_space = each.value.address_space

  subnets = {
    for subnet_key, subnet in each.value.subnets :
    subnet_key => {
      name = local.subnet_names[
        "${each.key}-${subnet_key}"
      ]
      address_prefixes = subnet.address_prefixes

      
    }
  }
}
  
