output "resource_group_names" {
  description = "Names of the created resource groups."
  value       = local.resource_group_names
}

output "resource_group_ids" {
  description = "Resource IDs of the created resource groups."

  value = {
    for key, resource_group in module.resource_group :
    key => resource_group.resource_id
  }
}

output "vnet_names" {
  description = "Names of the created virtual networks."
  value       = local.vnet_names
}

output "vnet_ids" {
  description = "Resource IDs of the created virtual networks."

  value = {
    for key, virtual_network in module.virtual_network :
    key => virtual_network.resource_id
  }
}

output "subnet_names" {
  description = "Names of the created subnets."
  value       = local.subnet_names
}

output "nsg_names" {
  description = "Names of the created network security groups."
  value       = local.nsg_names
}

output "nsg_ids" {
  description = "Resource IDs of the created network security groups."

  value = {
    for key, network_security_group in module.network_security_group :
    key => network_security_group.resource_id
  }
}