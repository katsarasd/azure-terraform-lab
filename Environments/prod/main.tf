module "resource_group" {
  
  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name = "rg-${var.resource_groups.workload}-${var.resource_groups.role}-${var.enviroment}-${var.location_short}"
  location = var.location
}

