variable "location" {
  description = "Name of the Azure region."
  type        = string
}

variable "location_short" {
  description = "Short name of the Azure region."
  type        = string
}

variable "environment" {
  type        = string
  description = "The name segment for the environment."
}

variable "resource_name_sequence" {
  type        = number
  description = "The number to use for the resource names."
  default     = 1

  validation {
    condition = (
      var.resource_name_sequence_start >= 1 &&
      var.resource_name_sequence_start <= 99
    )

    error_message = "The number must be between 1 and 99."
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

variable "resource_groups" {
  description = "Resource groups to create."

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
      role             = string
      address_prefixes = list(string)
      nsg_enabled      = optional(bool, false)
    }))
  }))
}