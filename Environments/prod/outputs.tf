output "resource_names" {
  value = local.resource_names
}

output "resource_ids" {
  value = {
    resource_group          = module.resource_group.resource_id
    virtual_network         = module.virtual_network.resource_id
    network_security_group  = module.network_security_group.resource_id
  }
}