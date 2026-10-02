locals {
  resource_group_names = {
    for key, resource_group in var.resource_groups :
    key => "rg-${resource_group.workload}-${var.environment}-${resource_group.role}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }
}

