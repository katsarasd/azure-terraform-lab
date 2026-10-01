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

variable resource_groups{
    type = map(object({
        workload = string
        role     = string
    }))
    
}