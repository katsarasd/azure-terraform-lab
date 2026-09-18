variable "environment" {
  description = "Deployment environment, for example prod or uat."
  type        = string
}

variable "location" {
  description = "Azure region used for the deployment."
  type        = string
}

variable "location_short" {
  description = "Short name of the Azure region."
  type        = string
}

variable "dns_servers" {
  description = "Custom DNS servers assigned to all virtual networks."
  type        = list(string)
}

variable "networks" {
  description = "Configuration of the hub and spoke virtual networks."

  type = map(object({
    resource_group_name = string
    virtual_network_name = string
    address_space        = list(string)

    subnets = map(object({
      name                            = string
      address_prefixes                = list(string)
      default_outbound_access_enabled = optional(bool, false)

      routes = optional(map(object({
        name                   = string
        address_prefix         = string
        next_hop_type          = string
        next_hop_in_ip_address = optional(string)
      })), {})
    }))
  }))
}