module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value
  location = var.location
}
module "network_security_group" {
  for_each = local.nsgs

  source = "Azure/avm-res-network-networksecuritygroup/azurerm"

  name     = local.nsg_names[each.key]
  location = var.location

  resource_group_name = module.resource_group[
    each.value.resource_group
  ].name
}


module "virtual_network" {
  for_each = var.vnets

  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  name     = local.vnet_names[each.key]
  location = var.location

  parent_id = module.resource_group[
    each.value.resource_group
  ].resource_id

  address_space = each.value.address_space

  dns_servers = {
    dns_servers = var.dns_servers
  }

  subnets = {
    for subnet_key, subnet in each.value.subnets :
    subnet_key => {
      name = local.subnet_names[
        "${each.key}-${subnet_key}"
      ]

      address_prefixes = subnet.address_prefixes

      network_security_group = subnet.nsg_enabled ? {
        id = module.network_security_group[
          "${each.key}-${subnet_key}"
        ].resource_id
      } : null
    }
  }
}


module "route_table" {
  for_each = local.route_tables

  source = "Azure/avm-res-network-routetable/azurerm"

  name     = local.route_table_names[each.key]
  location = var.location

  resource_group_name = module.resource_group[
    each.value.resource_group
  ].name

  routes = {
    default_to_firewall = {
      name                   = "default-to-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.firewall_next_hop_address
    }

    vnet_to_firewall = {
      name                   = "vnet-to-firewall"
      address_prefix         = each.value.vnet_address_space
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.firewall_next_hop_address
    }

    subnet_vnet_local = {
      name           = "subnet-vnet-local"
      address_prefix = each.value.subnet_address_prefix
      next_hop_type  = "VnetLocal"
    }
  }
  subnet_resource_ids = {
    "${each.value.vnet_key}-${each.value.subnet_key}" = module.virtual_network[
      each.value.vnet_key
    ].subnets[
      each.value.subnet_key
    ].resource_id
  }
}

module "fortinet_ha" {
  source = "./fortinet-ha"

  location            = var.location
  resource_group_name = module.resource_group["con_hub"].name
  common_tags         = var.common_tags
  zone1 = var.zone1
  zone2 = var.zone2
  size = var.fortigate_vm_size
  firewallname1 = var.firewallname1
  firewallname2 = var.firewallname2

 ha_management_subnet_id = module.virtual_network["con"].subnets["fgt-hamgmt"].resource_id
 external_subnet_id      = module.virtual_network["con"].subnets["fgt-external"].resource_id
 internal_subnet_id      = module.virtual_network["con"].subnets["fgt-internal"].resource_id
 ha_sync_subnet_id       = module.virtual_network["con"].subnets["fgt-hasync"].resource_id

  activeport1 = var.activeport1
  activeport2 = var.activeport2
  activeport3 = var.activeport3
  activeport4 = var.activeport4

  passiveport1 = var.passiveport1
  passiveport2 = var.passiveport2
  passiveport3 = var.passiveport3
  passiveport4 = var.passiveport4

  activeport1mask = var.activeport1mask
  activeport2mask = var.activeport2mask
  activeport3mask = var.activeport3mask
  activeport4mask = var.activeport4mask

  passiveport1mask = var.passiveport1mask
  passiveport2mask = var.passiveport2mask
  passiveport3mask = var.passiveport3mask
  passiveport4mask = var.passiveport4mask

  port1gateway = var.port1gateway
  port2gateway = var.port2gateway
  port3gateway = var.port3gateway

  internal_lb             = var.internal_lb
  internal_lb_frontend_ip = var.firewall_next_hop_address

  external_lb     = var.external_lb
  external_lb_pip = var.external_lb_pip

  adminusername = var.fortigate_admin_username
  adminpassword = var.fortigate_admin_password
  adminsport    = var.fortigate_admin_port

  publisher  = var.fortigate_publisher
  fgtoffer   = var.fortigate_offer
  fgtsku     = var.fortigate_sku
  arch       = var.fortigate_arch
  fgtversion = var.fortigate_version

  license_type   = var.fortigate_license_type
  license_format = var.fortigate_license_format
  license        = var.fortigate_license
  license2       = var.fortigate_license2
}