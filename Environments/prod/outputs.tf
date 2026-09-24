output "resource_group_names" {
  value = local.resource_group_names
}

output "resource_group_ids" {
  value = {
    for key, rg in module.resource_group :
    key => rg.resource_id
  }
}