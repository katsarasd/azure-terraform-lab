location                  = "Italy North"
location_short            = "itn"
environment               = "prd"
resource_name_sequence    = 1
dns_servers               = [ "10.126.16.4", "10.126.16.5"]

firewall_next_hop_address = "10.216.0.68"
external_lb               = "lbe-fgt-con-itn"
internal_lb               = "lbi-fgt-con-prod-itn"
external_lb_pip           = "pip-lbe-fgt-con-itn"
firewallname1             = "fgt-con-prod-itn-01"
firewallname2             = "fgt-con-prod-itn-02"
fortigate_admin_username  = "afentiko"
fortigate_admin_password  = "Kodikos2026!"

# Active FortiGate interface IPs
activeport1 = "10.216.0.4"
activeport2 = "10.216.0.69"
activeport3 = "10.216.0.196"
activeport4 = "10.216.0.132"

# Passive FortiGate interface IPs
passiveport1 = "10.216.0.5"
passiveport2 = "10.216.0.70"
passiveport3 = "10.216.0.197"
passiveport4 = "10.216.0.133"

activeport1mask = "255.255.255.192"
activeport2mask = "255.255.255.192"
activeport3mask = "255.255.255.192"
activeport4mask = "255.255.255.192"

passiveport1mask = "255.255.255.192"
passiveport2mask = "255.255.255.192"
passiveport3mask = "255.255.255.192"
passiveport4mask = "255.255.255.192"

port1gateway = "10.216.0.1"
port2gateway = "10.216.0.65"
port3gateway = "10.216.0.193"

resource_groups = {
  con_hub = {
    workload = "con"
    role     = "hub"
  }

  idnt_net = {
    workload = "idnt"
    role     = "net"
  }

  idnt_dc = {
    workload = "idnt"
    role     = "dc"
  }

  idnt_ca = {
    workload = "idnt"
    role     = "ca"
  }

  web_net = {
    workload = "web"
    role     = "net"
  }

  web_app = {
    workload = "web"
    role     = "app"
  }

  web_sql = {
    workload = "web"
    role     = "sql"
  }

  web_st = {
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
      fgt-external = {
        role = "fgt-external"
        address_prefixes   = ["10.216.0.0/26"]
        nsg_enabled        = false
       route_table_enabled = false
      }

      fgt-internal = {
        role = "fgt-internal"
        address_prefixes   = ["10.216.0.64/26"]
        nsg_enabled        = false
       route_table_enabled = false
      }

      fgt-hasync = {
        role = "fgt-hasync"
        address_prefixes    = ["10.216.0.128/26"]
        nsg_enabled         = false
        route_table_enabled = false
      }

      fgt-hamgmt = {
        role = "hamgmt"
        address_prefixes    = ["10.216.0.192/26"]
        nsg_enabled         = false
        route_table_enabled = false
      }

      azure-bastion = {
        name = "AzureBastionSubnet"
        role = "azure-bastion"
        address_prefixes = ["10.216.1.0/26"]
        nsg_enabled = false
       route_table_enabled = false
      }

      shared-services = {
        role = "shared-services"
        address_prefixes = ["10.216.1.64/26"]
        nsg_enabled = true
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
        role                = "dc"
        address_prefixes    = ["10.126.16.0/28"]
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
        role                = "app"
        address_prefixes    = ["10.126.32.0/24"]
        nsg_enabled         = true
        route_table_enabled = true
      }

      sql = {
        role                = "sql"
        address_prefixes    = ["10.126.33.0/24"]
        nsg_enabled         = true
        route_table_enabled = true
      }

      pe = {
        role                = "pe"
        address_prefixes    = ["10.126.34.0/26"]
        nsg_enabled         = true
        route_table_enabled = true
      }
    }
  }
}