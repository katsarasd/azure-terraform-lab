variable location {
    description = "Azure Region"
    type = string
}

variable location_short {
    description = "Azure Region Short Name"
    type        = string
}

variable environment {
    description = "Azure Enviroment"
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

variable az_bastion {
    type = string
}

variable resource_groups{
    type = map(object({
        workload = string
        role     = string
    }))
}

variable virtual_networks{
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