module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value
  location = var.location
}

module "network_security_group" {
  for_each = local.nsgs

  source = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.2"
  name     = local.nsg_names[each.key]
  location = var.location

  resource_group_name = module.resource_group[each.value.resource_group].name
}

module "virtual_network" {
  for_each      = var.vnets
  source        = "Azure/avm-res-network-virtualnetwork/azurerm"
  name          = local.vnet_names[each.key]
  location      = var.location
  parent_id     = module.resource_group[each.value.resource_group].resource_id
  address_space = each.value.address_space

  subnets = {
    for subnet_key, subnet in each.value.subnets :
    subnet_key => {
      name = local.subnet_names["${each.key}-${subnet_key}"]

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


module "bastion_public_ip" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "0.2.1"

  name                = var.bastion_pubic_ip_name
  location            = var.location
  resource_group_name = module.resource_group["con_hub"].name

  allocation_method = "Static"
  sku               = "Standard"
  sku_tier          = "Regional"

  
}

module "bastion" {
  source  = "Azure/avm-res-network-bastionhost/azurerm"
  version = "0.9.0"

  name      = var.bastion_name
  location  = var.location
  parent_id = module.resource_group["con_hub"].resource_id

  sku = "Standard"

  ip_configuration = {
    name = "bastion-ip-configuration"

    subnet_id = module.virtual_network["con"].subnets["azure-bastion"].resource_id
    
    create_public_ip     = false
    public_ip_address_id = module.bastion_public_ip.resource_id
  }

  copy_paste_enabled = true
  file_copy_enabled  = true

}

module "windows_vm" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.21.0"

  name                = "vm-con-prd-itn-01"
  computer_name       = "vmcon01"
  location            = var.location
  resource_group_name = module.resource_group["con_vm"].name

  zone = null
  encryption_at_host_enabled = false

  os_type  = "Windows"
  sku_size = "Standard_D2s_v6"

  network_interfaces = {
    primary = {
      name = "vm-con-prd-itn-01"

      ip_configurations = {
        primary = {
          name                          = "ipconfig1"
          private_ip_subnet_resource_id = module.virtual_network["con"].subnets["management"].resource_id
          create_public_ip_address      = false
        }
      }
    }
  }

  account_credentials = {
    admin_credentials = {
      username                           = "itsupport"
      password                           = "Kodikos2026!"
      generate_admin_password_or_ssh_key = false
    }

    password_authentication_disabled = true
  }

  enable_telemetry = false

 }


  
