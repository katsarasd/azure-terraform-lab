environment = "prod"
location = "Italy North"
location_short = "itn"
resource_name_sequence = 1
dns_servers = ["10.126.16.4","10.126.16.5"]

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
  web_sql = {
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
      firewall = {
        role           = "fw"
        address_prefix = "10.126.0.0/24"
        create_nsg     = false
      }
      mgmt = {
        role           = "mgmt"
        address_prefix = "10.126.1.0/24"
        create_nsg     = true
      }


    }
  }

  idnt = {
    workload       = "idnt"
    resource_group = "idnt_net"
    address_space  = ["10.126.16.0/20"]

    subnets = {
      dc = {
        role           = "dc"
        address_prefix = "10.126.16.0/28"
        create_nsg     = true
      }

      ca = {
        role           = "ca"
        address_prefix = "10.126.16.16/28"
        create_nsg     = true
      }
    }
  }

  web = {
    workload       = "web"
    resource_group = "web_net"
    address_space  = ["10.126.32.0/20"]

    subnets = {
      app = {
        role           = "app"
        address_prefix = "10.126.32.0/24"
        create_nsg     = true
      }

      sql = {
        role           = "sql"
        address_prefix = "10.126.33.0/24"
        create_nsg     = true
      }
      pe = {
        role           = "pe"
        address_prefix = "10.126.34.0/26"
        create_nsg     = true
      }
    }
  }
}