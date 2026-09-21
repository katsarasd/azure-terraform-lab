module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"

  location = var.location_short
  name     = local.resource_names.resource_group_name
  
}