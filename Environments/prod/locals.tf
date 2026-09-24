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
      "${vnet_key}-${subnet_key}" => "snet-${subnet.role}-${vnet.workload}-${var.environment}-${var.location_short}"
    }
  ]...)

  nsgs = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}-${subnet_key}" => {
        workload       = vnet.workload
        resource_group = vnet.resource_group
        subnet_role    = subnet.role
      } if subnet.nsg_enabled
    }
  ]...)

  nsg_names = {
    for key, nsg in local.nsgs :
    key => "nsg-snet-${nsg.subnet_role}-${nsg.workload}-${var.environment}-${var.location_short}"
  }
}