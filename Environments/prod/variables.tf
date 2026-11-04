variable location {
  type = string
}

variable "vnets" {
  description = "Virtual networks and their subnets."

  type = map(object({
    workload       = string
    resource_group = string
    address_space  = list(string)

    subnets = map(object({
      role                = string
      address_prefixes    = list(string)
      nsg_enabled         = optional(bool, false)
      route_table_enabled = optional(bool, false)
    }))
  }))
}