module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = each.value
  location = var.location
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
      name = local.subnet_names[
        "${each.key}-${subnet_key}"
      ]
      address_prefixes = subnet.address_prefixes

      
    }
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

    subnet_id = module.virtual_network[
      "con"
    ].subnets[
      "azure-bastion"
    ].resource_id

    public_ip_address_id = module.bastion_public_ip.resource_id
  }

  copy_paste_enabled = true
  file_copy_enabled  = false

  
}

  
