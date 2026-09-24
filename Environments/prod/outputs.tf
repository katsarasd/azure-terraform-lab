output "resource_group_names" {
  value = local.resource_group_names
}

output "vnet_names" {
value = local.vnet_names
}
output "resource_group_ids" {
  value = {
    for key, rg in module.resource_group :
    key => rg.resource_id
  }
}

output "vnet_ids" {
  value = {
    for key, vnet in module.virtual_network :
    key => vnet.resource_id
  }
}