environment    = "prod"
location       = "Italy North"
location_short = "itn"

dns_servers = ["10.216.16.4","10.216.16.5"]

networks = {
  hub = {
    resource_group_name = "rg-con-hub-prod-itn-01"
    vnet_name           = "vnet-con-prod-itn-01"
    address_space       = ["10.216.0.0/20"]

    subnets = {
      firewall = {
        name                            = "snet-firewall-prod"
        address_prefixes                = ["10.216.0.0/26"]
        default_outbound_access_enabled = false
      }

      management = {
        name                            = "snet-management-prod"
        address_prefixes                = ["10.216.0.64/26"]
        default_outbound_access_enabled = false
      }
    }
  }

  spoke01 = {
    resource_group_name = "rg-spoke01-prod-net-itn-01"
    vnet_name           = "vnet-spoke01-prod-itn-01"
    address_space       = ["10.216.16.0/20"]

    subnets = {
      dc = {
        name                            = "snet-dc-spoke01-prod"
        address_prefixes                = ["10.216.16.0/28"]
        default_outbound_access_enabled = false
      }

      ca = {
        name                            = "snet-ca-spoke01-prod"
        address_prefixes                = ["10.216.16.16/28"]
        default_outbound_access_enabled = false
      }

      pki = {
        name                            = "snet-pki-spoke01-prod"
        address_prefixes                = ["10.216.16.32/28"]
        default_outbound_access_enabled = false
      }
    }
  }

  spoke02 = {
    resource_group_name = "rg-spoke02-prod-net-itn-01"
    vnet_name           = "vnet-spoke02-prod-itn-01"
    address_space       = ["10.216.32.0/20"]

    subnets = {
      private_endpoints = {
        name                            = "snet-pe-spoke02-prod"
        address_prefixes                = ["10.216.32.0/28"]
        default_outbound_access_enabled = false
      }

      application_gateway = {
        name                            = "snet-appgw-spoke02-prod"
        address_prefixes                = ["10.216.32.16/28"]
        default_outbound_access_enabled = false
      }
    }
  }

  spoke03 = {
    resource_group_name = "rg-spoke03-prod-net-itn-01"
    vnet_name           = "vnet-spoke03-prod-itn-01"
    address_space       = ["10.216.48.0/20"]

    subnets = {
      private_endpoints = {
        name                            = "snet-pe-spoke03-prod"
        address_prefixes                = ["10.216.48.0/28"]
        default_outbound_access_enabled = false
      }

      application_gateway = {
        name                            = "snet-appgw-spoke03-prod"
        address_prefixes                = ["10.216.48.16/28"]
        default_outbound_access_enabled = false
      }
    }
  }
}