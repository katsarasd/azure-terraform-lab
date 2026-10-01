output "resource_group_names" {
  value = local.resource_group_names
}
output "resource_group_id" {
  description = "The resource Id of the resource group"
  value = {
    for key, resource_group in module.resource_group :
    key => resource_group.resource_id
  }
}