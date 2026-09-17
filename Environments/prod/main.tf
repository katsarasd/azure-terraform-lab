module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-${var.environment}-${var.location_short}-01"
  location = var.location
}

