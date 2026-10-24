location ="Italy North"
location_short = "itn"
environment = "prd"
resource_name_sequence = 1
az_bastion = "bastion-prd-itn-01"

resource_groups = {
  "con_hub" = {
    workload = "con"
    role     = "hub"
  }
}

vnets = {
  con = {
    workload       = "con"
    resource_group = "con_hub"
    address_space  = ["10.126.0.0/20"]
  
  subnets = {
    AzureBastion = {
      role                  = "AzureBastionSubnet"
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