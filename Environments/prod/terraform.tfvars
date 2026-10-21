location ="Italy North"
location_short = "itn"
enviroment = "prd"
az_bastion = "bastion-prd-itn-01"

resource_groups = {
  "con_hub" = {
    workload = "con"
    role     = "hub"
  }
}

virtual_networks = {
  "con" = {
    workload = "con"
    resource_group = "con_hub"
    address_space = "10.126.0.0/20"
  
  subnets = {
    management = {
      role = "mgmt"
    }
  }
  }
}