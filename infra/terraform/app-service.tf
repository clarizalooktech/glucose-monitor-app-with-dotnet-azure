# Get existing App Service Plan if it exists
data "azurerm_service_plan" "existing" {
  count               = var.app_service_plan_exists ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
}

# Create App Service Plan only if it doesn't exist
resource "azurerm_service_plan" "app_service_plan" {
  count               = !var.app_service_plan_exists ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  os_type             = "Linux"
  sku_name            = "B1" # Basic tier that supports containers
}

# Use either the existing or new App Service Plan
locals {
  app_service_plan_id = var.app_service_plan_exists ? data.azurerm_service_plan.existing[0].id : (length(azurerm_service_plan.app_service_plan) > 0 ? azurerm_service_plan.app_service_plan[0].id : null)
}

# App Service for API
resource "azurerm_linux_web_app" "api" {
  count               = !var.app_service_exists ? 1 : 0  # Simplify the count condition
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  service_plan_id     = local.app_service_plan_id

  # Add a depends_on to ensure the app service plan exists before creating the web app
  depends_on = [
    azurerm_service_plan.app_service_plan
  ]

site_config {
  application_stack {
    # Remove the duplication in the image name
    docker_image_name        = "glucose-monitor-api:latest"
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
  value = length(azurerm_linux_web_app.api) > 0 ? "https://${azurerm_linux_web_app.api[0].default_hostname}" : "No new App Service created"
}

# Output the App Service name
output "app_service_name" {
  value = length(azurerm_linux_web_app.api) > 0 ? azurerm_linux_web_app.api[0].name : (var.app_service_exists ? "${var.app_name}-api" : "No App Service")
}

# Data source to get existing App Service if it exists
data "azurerm_linux_web_app" "existing_api" {
  count               = var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.existing[0].id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.api[0].identity[0].principal_id
  depends_on           = [azurerm_linux_web_app.api]
}