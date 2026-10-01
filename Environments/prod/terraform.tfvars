location = "Italy North"
location_short = "itn"
environment = "prd"
resource_name_sequence = 1

resource_groups = {
  "con_hub" = {
    workload = "con"
    role     = "hub"
  }
  "idnt_net"= {
    workload ="idnt"
    role     ="net" 
  }
  "web_net"= {
    workload ="web"
    role     ="net"
}
}