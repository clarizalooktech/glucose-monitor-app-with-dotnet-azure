# Check if ACR exists
data "azurerm_container_registry" "existing" {
  count               = var.create_infrastructure ? 0 : 1
  name                = var.acr_name
  resource_group_name = local.resource_group_name
}

# Create ACR only if it doesn't exist and create_infrastructure is true
resource "azurerm_container_registry" "acr" {
  count               = var.create_infrastructure ? 1 : 0
  name                = var.acr_name
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  sku                 = "Basic"
  admin_enabled       = true
}

# Local to reference the correct ACR properties
locals {
  acr_login_server   = var.create_infrastructure ? (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].login_server : "") : data.azurerm_container_registry.existing[0].login_server
  acr_admin_username = var.create_infrastructure ? (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].admin_username : "") : data.azurerm_container_registry.existing[0].admin_username
  acr_admin_password = var.create_infrastructure ? (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].admin_password : "") : data.azurerm_container_registry.existing[0].admin_password
}