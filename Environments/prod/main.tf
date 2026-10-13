module "resource_group" {
  location = var.location
  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-${resource_groups}-${var.enviroment}-${var.location_short}"
}

