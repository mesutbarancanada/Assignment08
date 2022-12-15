resource "azurerm_storage_account" "a8storage" {
  name                     = "a8storagembrn"
  resource_group_name      = azurerm_resource_group.rga8.name
  location                 = azurerm_resource_group.rga8.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}