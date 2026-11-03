module "resource_group" {
  

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-demo-test"
  location = var.location
}