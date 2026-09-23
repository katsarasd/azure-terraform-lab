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
  description = "Resource groups to create"

  type = map(object({
    workload = string
    role     = string
  }))
}

# variable "resource_name_workload" {
  # type        = string
  # description = "The name segment for the workload"
  # default     = "con"

# variable "resource_name_templates" {
# type        = map(string)
# description = "A map of resource names to use"
#  default = {
#    resource_group_name  = "rg-$${workload}-$${environment}-$${location_short}-$${sequence}"

