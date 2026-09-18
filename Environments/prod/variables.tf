variable "environment" {
  type    = string
  
}
variable "location" {
  type    = string

}

variable "location_short" {
  type    = string

}

variable "hub-vnet" {
  type = list(string)
}

variable "spoke01-vnet" {
  type = list(string)
}

variable "spoke02-vnet" {
  type = list(string)
}

variable "spoke03-vnet" {
  type = list(string)
}