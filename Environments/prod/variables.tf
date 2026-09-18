variable "environment" {
  type    = string
  
}
variable "location" {
  type    = string

}

variable "location_short" {
  type    = string

}

variable "vnets" {
  type = map(object({
    address_space = list(string)
  }))
}