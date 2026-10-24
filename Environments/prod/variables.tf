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
variable "zone1" {
  description = "Azure Availability Zone."
  type = string
}

variable "zone2" {
  description = "Azure Availability Zone."
  type = string
}

variable bastion_name {
    type = string
}
variable bastion_pubic_ip {
    type = string
}
variable resource_groups{
    type = map(object({
        workload = string
        role     = string
    }))
}

variable vnets{
    type = map(object({
        workload       = string
        resource_group = string
        address_space  = list(string)
    
    subnets = map(object({
        name                = optional(string)
        role                = string
        address_prefixes    = list(string)
        nsg_enabled         = optional(bool, false)
        route_table_enabled = optional(bool, false)
    }))
}))

}