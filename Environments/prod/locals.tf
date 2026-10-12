locals {
  resource_group_names = {
    for key, resource_group in var.resource_groups :
    key => "rg-${resource_group.workload}-${var.environment}-${resource_group.role}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }

vnet_names = {
    for key, vnet in var.vnets :
    key => "vnet-${vnet.workload}-${var.environment}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }

  subnet_names = merge([
  for vnet_key, vnet in var.vnets : {
    for subnet_key, subnet in vnet.subnets :
    "${vnet_key}-${subnet_key}" => coalesce(
      subnet.name,
      "snet-${subnet.role}-${vnet.workload}-${var.environment}-${var.location_short}"
    )
  }
]...)

  nsgs = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}-${subnet_key}" => {
        workload       = vnet.workload
        resource_group = vnet.resource_group
        subnet_role    = subnet.role
      }
      if subnet.nsg_enabled
    }
  ]...)

  nsg_names = {
    for key, nsg in local.nsgs :
    key => "nsg-${nsg.subnet_role}-${nsg.workload}-${var.environment}-${var.location_short}"
  }

  route_tables = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}-${subnet_key}" => {
        workload              = vnet.workload
        resource_group        = vnet.resource_group
        subnet_role           = subnet.role
        vnet_key              = vnet_key
        subnet_key            = subnet_key
        vnet_address_space     = vnet.address_space[0]
        subnet_address_prefix = subnet.address_prefixes[0]
      }
      if subnet.route_table_enabled
    }
  ]...)

  route_table_names = {
    for key, route_table in local.route_tables :
    key => "rt-snet-${route_table.subnet_role}-${route_table.workload}-${var.environment}-${var.location_short}"
  }
}