resource "random_id" "randomId" {
  keepers = {
    resource_group_name = var.resource_group_name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "fgtstorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}