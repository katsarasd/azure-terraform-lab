variable "environment" {
  type    = string
}

variable "location" {
  type    = string
}

variable "location_short" {
  type    = string
}

variable "address_space_hub-vnet" {
  type = list(string)
}

variable "address_space_spoke01-vnet" {
  type = list(string)
}

variable "address_space_spoke02-vnet" {
  type = list(string)
}

variable "address_space_spoke03-vnet" {
  type = list(string)
}

variable "dns_servers" {
  type = list(string)
}