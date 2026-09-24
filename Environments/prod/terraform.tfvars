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
  web_app = {
    workload = "web"
    role     = "sql"
  }
  web_app = {
    workload = "web"
    role     = "st"
  }
}