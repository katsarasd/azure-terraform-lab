module "resource_group" {
  location = var.location
  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-${resource_group.workload}-${resource_group.role}-${var.enviroment}-${var.location_short}"
}

