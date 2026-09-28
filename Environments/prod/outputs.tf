output "resource_group_names" {
  value = local.resource_group_names
}

output "resource_group_ids" {
  value = {
    for key, resource_group in module.resource_group :
    key => resource_group.resource_id
  }
}

output "vnet_names" {
  value = local.vnet_names
}

output "vnet_ids" {
  value = {
    for key, virtual_network in module.virtual_network :
    key => virtual_network.resource_id
  }
}

output "subnet_names" {
  value = local.subnet_names
}

output "nsg_names" {
  value = local.nsg_names
}

output "nsg_ids" {
  value = {
    for key, network_security_group in module.network_security_group :
    key => network_security_group.resource_id
  }
}

output "nsg_associations" {
  value = {
    for key, nsg in local.nsgs :
    key => {
      subnet_name = local.subnet_names[key]
      nsg_name    = local.nsg_names[key]
      nsg_id      = module.network_security_group[key].resource_id
    }
  }
}