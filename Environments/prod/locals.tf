locals {

  resource_group_names = {
    for key, rg in var.resource_groups :
    key => "rg-${rg.workload}-${var.environment}-${rg.role}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }

  vnet_names = {
    for key, vnet in var.vnets :
    key => "vnet-${vnet.workload}-${var.environment}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }
}

locals {

  nsg_names = {
    for key, nsg in var.nsgs :
    key => "nsg-snet-${nsg.subnet_role}-${nsg.workload}-${var.environment}-${var.location_short}"
  }

}