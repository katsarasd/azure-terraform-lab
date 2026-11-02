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
variable "dns_servers" {
  description = "Custom DNS servers assigned to all virtual networks."
  type        = list(string)

  validation {
    condition     = length(var.dns_servers) == 2
    error_message = "Exactly two custom DNS servers must be provided."
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
variable "internal_lb" {
  description = "Name of the FortiGate Internal Load Balancer."
  type        = string
}
variable "external_lb" {
  description = "Name of the FortiGate External Load Balancer."
  type        = string
}

variable "external_lb_pip" {
  description = "Name of the External Load Balancer Public IP."
  type        = string
}

variable "fortigate_vm_size" {
  description = "Azure VM size for the FortiGate appliances."
  type = string
  default = "Standard_D8as_v6"
}

variable "firewallname1" {
  description = "Name of the Active FortiGate."
  type = string
}

variable "firewallname2" {
  description = "Name of the Passive FortiGate."
  type = string
}
variable "fortigate_admin_username" {
  description = "FortiGate administrator username."
  type = string
}

variable "fortigate_admin_password" {
  description = "FortiGate administrator password."
  type = string
  sensitive = true
}

variable "fortigate_admin_port" {
  description = "FortiGate HTTPS administration port."
  type = string
  default ="8443"
}
variable "fortigate_publisher" {
  description = "FortiGate Marketplace publisher."
  type = string
  default = "fortinet"
}

variable "fortigate_offer" {
  description = "FortiGate Marketplace offer."
  type = string
  default = "fortinet_fortigate-vm_v5"
}

variable "fortigate_sku" {
  description = "FortiGate Marketplace SKU mapping."
  type = map(map(string))
}

variable "fortigate_arch" {
  description = "FortiGate architecture."
  type = string
}

variable "fortigate_version" {
  description = "FortiGate Marketplace image version."
  type = string
  default = "7.6.5"
}

variable "fortigate_license_type" {
  description = "FortiGate license type."
 type = string
}

variable "fortigate_license_format" {
  description = "FortiGate license format."
  type = string
  default = "file"
}

variable "fortigate_license" {
  description = "Active FortiGate license path."
  type = string
  default = ""
}

variable "fortigate_license2" {
  description = "Passive FortiGate license path."
  type = string
  default = ""
}
variable firewall_next_hop_address{
    description = "Firewall Interanl Virtual IP Address"
    type        = string
}

variable "activeport1" {
  type = string
}

variable "activeport2" {
  type = string
}

variable "activeport3" {
  type = string
}

variable "activeport4" {
  type = string
}
variable "activeport1mask" {
  description = "Subnet mask for Active FortiGate port1, external."
 type = string
}

variable "activeport2mask" {
  description = "Subnet mask for Active FortiGate port2, internal."
  type = string
}

variable "activeport3mask" {
  description = "Subnet mask for Active FortiGate port3, management."
  type = string
}

variable "activeport4mask" {
  description = "Subnet mask for Active FortiGate port4, HA sync."
  type = string
}

variable "passiveport1" {
  type = string
}

variable "passiveport2" {
  type = string
}

variable "passiveport3" {
  type = string
}

variable "passiveport4" {
  type = string
}
variable "passiveport1mask" {
  description = "Subnet mask for Passive FortiGate port1, external."
  type = string
}

variable "passiveport2mask" {
  description = "Subnet mask for Passive FortiGate port2, internal."
  type = string
}

variable "passiveport3mask" {
  description = "Subnet mask for Passive FortiGate port3, management."
  type = string
}

variable "passiveport4mask" {
  description = "Subnet mask for Passive FortiGate port4, HA sync."
  type = string
}

variable "port1gateway" {
description = "Gateway for FortiGate port1, external."
type = string
}

variable "port2gateway" {
description = "Gateway for FortiGate port2, internal."
type = string
}

variable "port3gateway" {
description = "Gateway for FortiGate port3, management."
type = string
}

variable "common_tags" {
  description = "Common tags applied to resources."
  type        = map(string)
  default     = {
    owner       = "Dev OPS Team"
    description = "Terraform-managed IaC"
    contact     = "Katsaras Dimitris"
    environment = "development"
  }
}

variable bastion_name {
    type = string
}
variable bastion_pubic_ip_name {
    type = string
}

variable firewall_next_hop_address{
  type =string
}

variable resource_groups{
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
      name                = optional(string)
      role                = optional(string)
      address_prefixes    = list(string)
      nsg_enabled         = optional(bool, false)
      route_table_enabled = optional(bool, false)
    }))
  }))
}
