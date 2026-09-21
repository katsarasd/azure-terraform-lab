locals {
  name_replacements = {
    workload    = var.resource_name_workload
    environment = var.environment
    location    = var.location_short
    sequence    = format("%03d", var.resource_name_sequence_start)
  }

  resource_names = { for key, value in var.resource_name_templates : key => templatestring(value, local.name_replacements) }
}