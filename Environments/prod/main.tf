module "rg-spoke01-net" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"

  name     = "rg-demo"
  location = "Italy North"

}