module "resource_group" {
  for_each = local.resource_group_names

  source = "Azure/avm-res-resources-resourcegroup/azurerm"

  location = var.location
  name     = each.value
}