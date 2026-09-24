locals {
  resource_group_names = {
    for key, rg in var.resource_groups :
    key => "rg-${rg.workload}-${var.environment}-${rg.role}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }

  vnet_names = {
    for key, vnet in var.vnets :
    key => "vnet-${vnet.workload}-${var.environment}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }

  nsgs = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}_${subnet_key}" => {
        workload       = vnet.workload
        resource_group = vnet.resource_group
        subnet_role    = subnet.role
        vnet_key       = vnet_key
        subnet_key     = subnet_key
      }
      if try(subnet.create_nsg, false)
    }
  ]...)

  nsg_names = {
    for key, nsg in local.nsgs :
    key => "nsg-snet-${nsg.subnet_role}-${nsg.workload}-${var.environment}-${var.location_short}"
  }

  expected_nsg_associations = {
    for key, nsg in local.nsgs :
    key => {
      vnet_key    = nsg.vnet_key
      subnet_key  = nsg.subnet_key
      subnet_name = "snet-${nsg.subnet_role}-${nsg.workload}-${var.environment}-${var.location_short}"
      nsg_name    = local.nsg_names[key]
    }
  }

  subnets_without_nsg = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}_${subnet_key}" => {
        vnet_key    = vnet_key
        subnet_key  = subnet_key
        subnet_name = "snet-${subnet.role}-${vnet.workload}-${var.environment}-${var.location_short}"
      }
      if !try(subnet.create_nsg, false)
    }
  ]...)
}