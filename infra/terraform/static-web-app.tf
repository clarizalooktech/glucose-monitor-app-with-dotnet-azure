# Check if Static Web App exists
data "azurerm_static_web_app" "existing" {
  count               = var.static_web_app_exists ? 1 : 0
  name                = "${var.app_name}-ui"
  resource_group_name = local.resource_group_name
}

# Azure Static Web App for UI
resource "azurerm_static_web_app" "ui" {
  count               = var.static_web_app_exists ? 0 : 1
  name                = "${var.app_name}-ui"
  resource_group_name = local.resource_group_name
  location            = "eastasia"  # Static Web Apps have limited regions
  sku_tier            = "Free"
  sku_size            = "Free"
}

# Output the Static Web App URL
output "ui_url" {
  value = var.static_web_app_exists ? data.azurerm_static_web_app.existing[0].default_host_name : azurerm_static_web_app.ui[0].default_host_name
}

# Output the deployment token (needed for GitHub Actions)
output "ui_deployment_token" {
  value     = var.static_web_app_exists ? data.azurerm_static_web_app.existing[0].api_key : azurerm_static_web_app.ui[0].api_key
  sensitive = true
}