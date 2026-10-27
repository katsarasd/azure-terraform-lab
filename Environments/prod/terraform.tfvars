location               ="Italy North"
location_short         = "itn"
environment            = "prd"
resource_name_sequence = 1
zone1                  = "1"
zone2                  = "2"
bastion_name           = "bastion-con-prd-itn"
bastion_pubic_ip_name  = "pip-bas-con-prd-itn"

resource_groups = {
  "con_hub" = {
    workload = "con"
    role     = "net"
  }
  "con_vm" = {
    workload = "con"
    role     = "vm"
  }
}

vnets = {
  con = {
    workload       = "con"
    resource_group = "con_hub"
    address_space  = ["10.126.0.0/20"]
  
  subnets = {
    azure-bastion = {
      name                  = "AzureBastionSubnet"
      address_prefixes      = ["10.126.2.0/24"]
        nsg_enabled         = false
        route_table_enabled = false
    }
    management = {
        role                = "mgmt"
        address_prefixes    = ["10.126.3.0/24"]
        nsg_enabled         = false
        route_table_enabled = false
      }
  }
  }
}