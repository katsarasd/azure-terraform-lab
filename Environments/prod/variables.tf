variable location {
    description = "Azure Region"
    type = string
}
variable location_short{
    description = "Short Name for Azure Region"
    type = string
}

variable environment{
    description = "Specifies if Prod/UAT/Dev"
    type        = string
}
variable "resource_name_sequence" {
  description = "Naming sequence."
  type        = number
  default     = 1

  validation {
    condition     = var.resource_name_sequence >= 1 && var.resource_name_sequence <= 99
    error_message = "Sequence must be between 1 and 99."
  }
}

variable "dns_servers" {
  description = "Custom DNS servers assigned to all virtual networks."
  type        = list(string)

  validation {
    condition     = length(var.dns_servers) == 2
    error_message = "Exactly two custom DNS servers must be provided."
  }
}

variable "firewall_next_hop_address" {
  description = "Private IP address of the firewall used as the next hop."
  type        = string
}

variable resource_groups{
    type = map(object({
        workload = string
        role     = string
    }))
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