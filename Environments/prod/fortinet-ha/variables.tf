variable "location" {
  description = "Azure region for the FortiGate deployment."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name for the FortiGate deployment."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to FortiGate resources."
  type        = map(string)
  default     = {}
}

variable "zone1" {
  description = "Availability Zone for the Active FortiGate."
  type        = string
}

variable "zone2" {
  description = "Availability Zone for the Passive FortiGate."
  type        = string
}

variable "size" {
  description = "Azure VM size for both FortiGate appliances."
  type        = string
  default     = "Standard_D8as_v6"
}

variable "firewallname1" {
  description = "Name of the Active FortiGate VM."
  type        = string
}

variable "firewallname2" {
  description = "Name of the Passive FortiGate VM."
  type        = string
}

variable "adminusername" {
  description = "FortiGate administrator username."
  type        = string
}

variable "adminpassword" {
  description = "FortiGate administrator password."
  type        = string
  sensitive   = true
}

variable "adminsport" {
  description = "FortiGate HTTPS administration port."
  type        = string
}

variable "publisher" {
  description = "FortiGate Marketplace image publisher."
  type        = string
  default     = "fortinet"
}

variable "fgtoffer" {
  description = "FortiGate Marketplace image offer."
  type        = string
  default     = "fortinet_fortigate-vm_v5"
}

variable "fgtsku" {
  description = "FortiGate Marketplace SKU mapping."
  type        = map(map(string))
}

variable "arch" {
  description = "FortiGate VM architecture used to select the Marketplace SKU."
  type        = string
}

variable "fgtversion" {
  description = "FortiGate Marketplace image version."
  type        = string
  default     = "latest"
}

variable "license_type" {
  description = "FortiGate licensing type, such as payg or byol."
  type        = string
}

variable "license_format" {
  description = "FortiGate license format, such as token or file."
  type        = string
  default     = "file"
}

variable "license" {
  description = "License file path for the Active FortiGate."
  type        = string
  default     = ""
}

variable "license2" {
  description = "License file path for the Passive FortiGate."
  type        = string
  default     = ""
}

variable "ha_management_subnet_id" {
  description = "Resource ID of the FortiGate management subnet."
  type        = string
}

variable "external_subnet_id" {
  description = "Resource ID of the FortiGate external subnet."
  type        = string
}

variable "internal_subnet_id" {
  description = "Resource ID of the FortiGate internal subnet."
  type        = string
}

variable "ha_sync_subnet_id" {
  description = "Resource ID of the FortiGate HA synchronization subnet."
  type        = string
}

variable "activeport1" {
  description = "Private IP of Active FortiGate port1, external."
  type        = string
}

variable "activeport2" {
  description = "Private IP of Active FortiGate port2, internal."
  type        = string
}

variable "activeport3" {
  description = "Private IP of Active FortiGate port3, management."
  type        = string
}

variable "activeport4" {
  description = "Private IP of Active FortiGate port4, HA sync."
  type        = string
}

variable "passiveport1" {
  description = "Private IP of Passive FortiGate port1, external."
  type        = string
}

variable "passiveport2" {
  description = "Private IP of Passive FortiGate port2, internal."
  type        = string
}

variable "passiveport3" {
  description = "Private IP of Passive FortiGate port3, management."
  type        = string
}

variable "passiveport4" {
  description = "Private IP of Passive FortiGate port4, HA sync."
  type        = string
}

variable "activeport1mask" {
  description = "Subnet mask of Active FortiGate port1."
  type        = string
}

variable "activeport2mask" {
  description = "Subnet mask of Active FortiGate port2."
  type        = string
}

variable "activeport3mask" {
  description = "Subnet mask of Active FortiGate port3."
  type        = string
}

variable "activeport4mask" {
  description = "Subnet mask of Active FortiGate port4."
  type        = string
}

variable "passiveport1mask" {
  description = "Subnet mask of Passive FortiGate port1."
  type        = string
}

variable "passiveport2mask" {
  description = "Subnet mask of Passive FortiGate port2."
  type        = string
}

variable "passiveport3mask" {
  description = "Subnet mask of Passive FortiGate port3."
  type        = string
}

variable "passiveport4mask" {
  description = "Subnet mask of Passive FortiGate port4."
  type        = string
}

variable "port1gateway" {
  description = "Gateway of the external subnet."
  type        = string
}

variable "port2gateway" {
  description = "Gateway of the internal subnet."
  type        = string
}

variable "port3gateway" {
  description = "Gateway of the management subnet."
  type        = string
}

variable "internal_lb" {
  description = "Name of the Internal Load Balancer."
  type        = string
}

variable "internal_lb_frontend_ip" {
  description = "Static frontend private IP of the Internal Load Balancer."
  type        = string
}

variable "external_lb" {
  description = "Name of the External Load Balancer."
  type        = string
}

variable "external_lb_pip" {
  description = "Name of the External Load Balancer Public IP."
  type        = string
}