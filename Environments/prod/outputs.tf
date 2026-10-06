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

output "subnet_ids" {
  value = merge([
    for vnet_key, virtual_network in module.virtual_network : {
      for subnet_key, subnet in virtual_network.subnets :
      "${vnet_key}-${subnet_key}" => subnet.resource_id
    }
  ]...)
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

output "route_table_names" {
  value = local.route_table_names
}

output "route_table_ids" {
  value = {
    for key, route_table in module.route_table :
    key => route_table.resource_id
  }
}

output "route_table_associations" {
  value = {
    for key, route_table in local.route_tables :
    key => {
      vnet_name       = local.vnet_names[route_table.vnet_key]
      subnet_name     = local.subnet_names[key]
      subnet_id       = module.virtual_network[route_table.vnet_key].subnets[route_table.subnet_key].resource_id
      route_table_name = local.route_table_names[key]
      route_table_id   = module.route_table[key].resource_id
    }
  }
}

output "firewall_next_hop_address" {
  value = var.firewall_next_hop_address
}

output "fortigate_resource_group" {
  value = module.fortinet_ha.ResourceGroup
}

output "fortigate_active_management_url" {
  value = module.fortinet_ha.ActiveMGMTPublicIP
}

output "fortigate_passive_management_url" {
  value = module.fortinet_ha.PassiveMGMTPublicIP
}
output "fortigate_external_lb_public_ip" {
  value = module.fortinet_ha.ExternalLBPublicIP
}

output "fortigate_internal_lb_frontend_ip" {
  value = module.fortinet_ha.InternalLBFrontendIP
}

output "fortigate_username" {
  value = module.fortinet_ha.Username
}

output "fortigate_password" {
  value     = module.fortinet_ha.Password
  sensitive = true
}