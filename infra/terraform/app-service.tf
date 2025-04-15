resource "azurerm_service_plan" "app_service_plan" {
  count               = !var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.rg[0].name
  location            = azurerm_resource_group.rg[0].location
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan (pay-as-you-go) and can use containers
}

# App Service for API
resource "azurerm_linux_web_app" "api" {
  count               = !var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = azurerm_resource_group.rg[0].name
  location            = azurerm_resource_group.rg[0].location
  service_plan_id     = azurerm_service_plan.app_service_plan[0].id

  site_config {
    application_stack {
      docker_image_name        = "${local.acr_login_server}/glucose-monitor-api:latest"
      docker_registry_url      = "https://${local.acr_login_server}"
      docker_registry_username = local.acr_admin_username
      docker_registry_password = local.acr_admin_password
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Output the App Service URL
output "api_url" {
  value = var.create_infrastructure && !var.app_service_exists ? "https://${azurerm_linux_web_app.api[0].default_hostname}" : "No new App Service created"
}

# Output the App Service name
output "app_service_name" {
  value = var.create_infrastructure && !var.app_service_exists ? azurerm_linux_web_app.api[0].name : (var.app_service_exists ? "${var.app_name}-api" : "No App Service")
}

# Data source to get existing App Service if it exists
data "azurerm_linux_web_app" "existing_api" {
  count               = var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = azurerm_resource_group.rg[0].name
}