module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"

  location = var.location
  name     = local.resource_names.resource_group_name
  
}