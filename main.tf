resource "azurerm_resource_group" "rg" {
    for_each = var.rg_map
  name     = each.value.rg_name
  location = each.value.location
}
resource "azurerm_storage_account" "storage" {
    for_each = var.rg_map
  name                     = each.value.storage_name
  resource_group_name      = azurerm_resource_group.rg_resource[each.key].name
  location                 = azurerm_resource_group.rg_resource[each.key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "container" {
    for_each = var.rg_map
  name                  = each.value.container_name
  storage_account_name  = each.value.storage_name
  container_access_type = "private"
  depends_on = [ azurerm_storage_account.storage ]
}