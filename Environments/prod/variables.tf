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
  description = "The name segment for the environment"
 
}

variable "dns_servers" {
  description = "Custom DNS servers assigned to all virtual networks."
  type        = list(string)

  validation {
    condition     = length(var.dns_servers) == 2
    error_message = "Exactly two custom DNS servers must be provided."
  }
}

variable "resource_name_sequence" {
  description = "Naming sequence"
  type        = number
  default     = 1

  validation {
    condition     = var.resource_name_sequence >= 1 && var.resource_name_sequence <= 99
    error_message = "Sequence must be between 1 and 99."
  }
}
variable "resource_groups" {
  description = "Resource groups to Create"

    type     = map(object({
    workload = string
    role     = string
  }))
}

