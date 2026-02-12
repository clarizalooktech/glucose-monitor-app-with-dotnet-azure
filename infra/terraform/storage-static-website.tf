# Data source for existing storage account
data "azurerm_storage_account" "existing_ui" {
  count               = var.static_website_exists ? 1 : 0
  name                = "${replace(var.app_name, "-", "")}uistorage"
  resource_group_name = local.resource_group_name
}

# Storage Account for Static Website
resource "azurerm_storage_account" "ui" {
  count                    = var.static_website_exists ? 0 : 1
  name                     = "${replace(var.app_name, "-", "")}uistorage"
  resource_group_name      = local.resource_group_name
  location                 = local.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Enable static website (only when creating new)
resource "azurerm_storage_account_static_website" "ui" {
  count              = var.static_website_exists ? 0 : 1
  storage_account_id = azurerm_storage_account.ui[0].id
  index_document     = "index.html"
}

# Output the Storage Account primary endpoint
output "ui_url" {
  value = var.static_website_exists ? data.azurerm_storage_account.existing_ui[0].primary_web_endpoint : azurerm_storage_account.ui[0].primary_web_endpoint
}

# Output the storage account name (needed for deployment)
output "storage_account_name" {
  value = var.static_website_exists ? data.azurerm_storage_account.existing_ui[0].name : azurerm_storage_account.ui[0].name
}