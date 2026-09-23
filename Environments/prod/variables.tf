variable "location" {
  description = "Name of the Azure region."
  type        = string
}

variable "location_short" {
  description = "Short name of the Azure region."
  type        = string
}

variable "resource_name_workload" {
  type        = string
  description = "The name segment for the workload"
  default     = "con"
}

variable "environment" {
  type        = string
  description = "The name segment for the environment"
 
}

variable "resource_name_sequence_start" {
  type        = number
  description = "The number to use for the resource names"
  default     = 1
  validation {
    condition     = var.resource_name_sequence_start >= 1 && var.resource_name_sequence_start <= 99
    error_message = "The number must be between 1 and 99"
  }
}

variable "resource_name_templates" {
  type        = map(string)
  description = "A map of resource names to use"
  default = {
    resource_group_name   = "rg-$${workload}-$${environment}-$${location_short}-$${sequence}"
  }
}