# Check if ACR exists
data "azurerm_container_registry" "existing" {
  count               = var.acr_exists ? 1 : 0
  name                = var.acr_name
  resource_group_name = local.resource_group_name
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  count               = var.acr_exists ? 0 : 1
  name                = var.acr_name
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  sku                 = "Basic"
  admin_enabled       = true
}

# Local to reference the correct ACR properties
locals {
  acr_login_server   = var.acr_exists ? data.azurerm_container_registry.existing[0].login_server : azurerm_container_registry.acr[0].login_server
  acr_admin_username = var.acr_exists ? data.azurerm_container_registry.existing[0].admin_username : azurerm_container_registry.acr[0].admin_username
  acr_admin_password = var.acr_exists ? data.azurerm_container_registry.existing[0].admin_password : azurerm_container_registry.acr[0].admin_password
}