locals {
  subnets = merge([
    for network_key, network in var.networks : {
      for subnet_key, subnet in network.subnets :
      "${network_key}.${subnet_key}" => {
        network_key                    = network_key
        subnet_key                     = subnet_key
        resource_group_name            = network.resource_group_name
        virtual_network_name           = network.virtual_network_name
        name                            = subnet.name
        address_prefixes                = subnet.address_prefixes
        default_outbound_access_enabled = subnet.default_outbound_access_enabled
        routes                          = subnet.routes
      }
    }
  ]...)
}