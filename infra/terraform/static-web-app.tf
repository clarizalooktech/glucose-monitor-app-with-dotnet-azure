# Azure Static Web App for UI
resource "azurerm_static_web_app" "ui" {
  count               = var.create_infrastructure ? 1 : 0
  name                = "${var.app_name}-ui"
  resource_group_name = local.resource_group_name
  location            = "eastasia"  # Static Web Apps have limited regions
  sku_tier            = "Free"
  sku_size            = "Free"
}

# Output the Static Web App URL
output "ui_url" {
  value = var.create_infrastructure ? azurerm_static_web_app.ui[0].default_host_name : null
}

# Output the deployment token (needed for GitHub Actions)
output "ui_deployment_token" {
  value     = var.create_infrastructure ? azurerm_static_web_app.ui[0].api_key : null
  sensitive = true
}