locals {
  resource_group_names = {
    for key, rg in var.resource_groups :
    key => "rg-${rg.workload}-${var.environment}-${rg.role}-${var.location_short}-${format("%02d", var.resource_name_sequence)}"
  }
}