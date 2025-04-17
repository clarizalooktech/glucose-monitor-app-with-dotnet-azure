# Get existing App Service Plan if it exists
data "azurerm_service_plan" "existing" {
  count               = var.app_service_plan_exists == "true" ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
}

# Create App Service Plan only if it doesn't exist
resource "azurerm_service_plan" "app_service_plan" {
  count               = var.app_service_plan_exists == "true" ? 0 : 1
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  os_type             = "Linux"
  sku_name            = "B1" # Basic tier that supports containers
}

# Use either the existing or new App Service Plan
locals {
  app_service_plan_id = var.app_service_plan_exists == "true" ? data.azurerm_service_plan.existing[0].id : (length(azurerm_service_plan.app_service_plan) > 0 ? azurerm_service_plan.app_service_plan[0].id : null)
}

# Data source to get existing App Service if it exists
data "azurerm_linux_web_app" "existing_api" {
  count               = var.app_service_exists == "true" ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
}

# App Service for API - Single resource now (used for both new and existing)
resource "azurerm_linux_web_app" "api" {
  count               = 1  # Always create this resource (we'll import into it later)
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
      # Use ACR credentials from locals
      docker_image_name = "glucose-monitor-api:${github.sha}"
      docker_registry_url      = "https://${local.acr_login_server}"
      docker_registry_username = local.acr_admin_username
      docker_registry_password = local.acr_admin_password
    }
  }

app_settings = {
  "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  "DOCKER_REGISTRY_SERVER_URL"          = "https://${local.acr_login_server}"
  "DOCKER_REGISTRY_SERVER_USERNAME"     = local.acr_admin_username
  "DOCKER_REGISTRY_SERVER_PASSWORD"     = local.acr_admin_password
}

  identity {
    type = "SystemAssigned"
  }

  # Add lifecycle ignore_changes - cannot use conditional
  lifecycle {
    ignore_changes = [
      site_config,
      app_settings,
    ]
  }
}

# Output the App Service URL
output "api_url" {
  value = "https://${azurerm_linux_web_app.api[0].default_hostname}"
}

# Output the App Service name
output "app_service_name" {
  value = azurerm_linux_web_app.api[0].name
}

# Consolidated role assignment that works for both new and existing ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.create_infrastructure ? azurerm_container_registry.acr[0].id : data.azurerm_container_registry.existing[0].id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.api[0].identity[0].principal_id
  depends_on           = [azurerm_linux_web_app.api]
}