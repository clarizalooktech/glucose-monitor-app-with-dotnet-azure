# Storage Account for Static Website
resource "azurerm_storage_account" "ui" {
  count                    = var.static_website_exists ? 0 : 1
  name                     = "${replace(var.app_name, "-", "")}uistorage"  # Storage names can't have dashes
  resource_group_name      = local.resource_group_name
  location                 = local.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  static_website {
    index_document = "index.html"
  }
}

# Output the Storage Account primary endpoint
output "ui_url" {
  value = var.static_website_exists ? null : azurerm_storage_account.ui[0].primary_web_endpoint
}

# Output the storage account name (needed for deployment)
output "storage_account_name" {
  value = var.static_website_exists ? null : azurerm_storage_account.ui[0].name
}