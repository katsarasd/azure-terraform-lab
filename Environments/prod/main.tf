module "resource_group" {
  
  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-demo"
  location = var.location
}
