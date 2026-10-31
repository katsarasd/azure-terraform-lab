location               ="Italy North"
location_short         = "itn"
environment            = "prd"
resource_name_sequence = 1
zone1                  = "1"
zone2                  = "2"
bastion_name           = "bastion-con-prd-itn"
bastion_pubic_ip_name  = "pip-bas-con-prd-itn"
firewall_next_hop_address = "10.216.0.4"

resource_groups = {
  "con_hub" = {
    workload = "con"
    role     = "net"
  }

  "con_vm" = {
    workload = "con"
    role     = "vm"
  }

  "idnt_net" = {
    workload = "idnt"
    role     = "net"
  }

  "idnt_dc" = {
    workload = "idnt"
    role     = "dc"
  }

  "idnt_ca" = {
    workload = "idnt"
    role     = "ca"
  }

  "web_net" = {
    workload = "web"
    role     = "net"
  }
  "web_app" = {
    workload = "web"
    role     = "app"
  }
  "web_app" = {
    workload = "web"
    role     = "sql"
  }
  "web_app" = {
    workload = "web"
    role     = "st"
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
        nsg_enabled         = true
        route_table_enabled = true
      }
  }
  }
  idnt = {
    workload       = "idnt"
    resource_group = "idnt_net"
    address_space  = ["10.126.16.0/20"]
  
  subnets = {
    dc = {
      name                  = "dc"
      address_prefixes      = ["10.126.16.0/28"]
        nsg_enabled         = true
        route_table_enabled = true
    }
    ca = {
        role                = "ca"
        address_prefixes    = ["10.126.16.16/28"]
        nsg_enabled         = true
        route_table_enabled = true
      }
  }
  }
  web = {
    workload       = "web"
    resource_group = "web_net"
    address_space  = ["10.126.32.0/20"]
  
  subnets = {
    app = {
      name                  = "app"
      address_prefixes      = ["10.126.32.0/24"]
        nsg_enabled         = true
        route_table_enabled = true
    }
    sql = {
        role                = "sql"
        address_prefixes    = ["10.126.33.0/24"]
        nsg_enabled         = true
        route_table_enabled = true
      }
      sta = {
        role                = "sta"
        address_prefixes    = ["10.126.34.0/28"]
        nsg_enabled         = true
        route_table_enabled = true
  }
  }
}
}