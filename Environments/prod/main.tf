module "resource_group" {
  location = var.location
  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-${resource_groups.workload}-${resource_groups.role}-${var.enviroment}-${var.location_short}"
}

