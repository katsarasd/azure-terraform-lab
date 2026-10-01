output "resource_group_names" {
  description = "The name of the resource group"
  value       = local.resource_group.names
}
output "resource_group_id" {
  description = "The resource Id of the resource group"
  value = {
    for key, resource_group in module.resource_group :
    key => resource_group.resource_id
  }
}