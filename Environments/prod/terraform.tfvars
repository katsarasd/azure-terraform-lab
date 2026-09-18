environment    = "prod"
location       = "Italy North"
location_short = "itn"

dns_servers = [
  "10.216.16.4",
  "10.216.16.5"
]

networks = {
  hub = {
    resource_group_name  = "rg-con-prod-itn-01"
    virtual_network_name = "vnet-con-prod-itn-01"
    address_space        = ["10.126.0.0/20"]

    subnets = {}
  }

  spoke01 = {
    resource_group_name  = "rg-spoke01-prod-net-itn-01"
    virtual_network_name = "vnet-spoke01-prod-itn-01"
    address_space        = ["10.126.16.0/20"]

    subnets = {
      dc = {
        name                            = "snet-dc-spoke01-prod"
        address_prefixes                = ["10.126.16.0/28"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      ca = {
        name                            = "snet-ca-spoke01-prod"
        address_prefixes                = ["10.126.16.16/28"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      pki = {
        name                            = "snet-pki-spoke01-prod"
        address_prefixes                = ["10.126.16.32/28"]
        default_outbound_access_enabled = false
        routes                          = {}
      }
    }
  }

  spoke02 = {
    resource_group_name  = "rg-spoke02-prod-net-itn-01"
    virtual_network_name = "vnet-spoke02-prod-itn-01"
    address_space        = ["10.126.32.0/20"]

    subnets = {
      app = {
        name                            = "snet-app-spoke02-prod"
        address_prefixes                = ["10.126.32.0/24"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      sql = {
        name                            = "snet-sql-spoke02-prod"
        address_prefixes                = ["10.126.33.0/24"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      private_endpoints = {
        name                            = "snet-pe-spoke02-prod"
        address_prefixes                = ["10.126.34.0/27"]
        default_outbound_access_enabled = false
        routes                          = {}
      }
    }
  }

  spoke03 = {
    resource_group_name  = "rg-spoke03-prod-net-itn-01"
    virtual_network_name = "vnet-spoke03-prod-itn-01"
    address_space        = ["10.126.48.0/20"]

    subnets = {
      web = {
        name                            = "snet-web-spoke03-prod"
        address_prefixes                = ["10.126.48.0/24"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      database = {
        name                            = "snet-db-spoke03-prod"
        address_prefixes                = ["10.126.49.0/24"]
        default_outbound_access_enabled = false
        routes                          = {}
      }

      private_endpoints = {
        name                            = "snet-pe-spoke03-prod"
        address_prefixes                = ["10.126.50.0/27"]
        default_outbound_access_enabled = false
        routes                          = {}
      }
    }
  }
}