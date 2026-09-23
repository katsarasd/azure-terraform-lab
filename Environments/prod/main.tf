module "resource_group" {
  

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  location = var.location
  name     = "rg-demo"
}
