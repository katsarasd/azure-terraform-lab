output "resource_group_names" {
  description = "Names of the created Resource Groups."
  value       = local.resource_group_names
}

output "resource_group_ids" {
  description = "Resource IDs of the created Resource Groups."

  value = {
    for key, rg in module.resource_group :
    key => rg.resource_id
  }
}

output "vnet_names" {
  description = "Names of the created Virtual Networks."
  value       = local.vnet_names
}

output "vnet_ids" {
  description = "Resource IDs of the created Virtual Networks."

  value = {
    for key, vnet in module.virtual_network :
    key => vnet.resource_id
  }
}

output "nsg_names" {
  description = "Names of the created Network Security Groups."
  value       = local.nsg_names
}

output "nsg_ids" {
  description = "Resource IDs of the created Network Security Groups."

  value = {
    for key, nsg in module.network_security_group :
    key => nsg.resource_id
  }
}

output "expected_nsg_associations" {
  description = "Expected association between subnets and Network Security Groups."

  value = {
    for key, association in local.expected_nsg_associations :

    key => {
      vnet_name   = local.vnet_names[association.vnet_key]
      subnet_name = association.subnet_name
      nsg_name    = association.nsg_name

      nsg_id = module.network_security_group[
        association.nsg_key
      ].resource_id
    }
  }
}

output "subnets_without_nsg" {
  description = "Subnets intentionally created without an NSG."

  value = {
    for key, subnet in local.subnets_without_nsg :

    key => {
      vnet_name   = local.vnet_names[subnet.vnet_key]
      subnet_name = subnet.subnet_name
    }
  }
}