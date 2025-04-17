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

# Only include import block when app service exists
# Note: Remove this comment and block after successful import
import {
  to = azurerm_linux_web_app.existing_imported[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Web/sites/${var.app_name}-api"
}

# Resource for imported App Service (only used during import)
resource "azurerm_linux_web_app" "existing_imported" {
  count               = var.app_service_exists == "true" ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  service_plan_id     = local.app_service_plan_id

  site_config {
    application_stack {
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
  
  # Ignore changes to prevent unwanted updates to the imported resource
  lifecycle {
    ignore_changes = [
      site_config,
      app_settings,
    ]
  }
}

# App Service for API (only created for new resources)
resource "azurerm_linux_web_app" "api" {
  count               = var.app_service_exists == "true" ? 0 : 1
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
  value = var.app_service_exists == "true" ?
    (length(azurerm_linux_web_app.existing_imported) > 0 ? "https://${azurerm_linux_web_app.existing_imported[0].default_hostname}" : "No imported App Service URL available") : 
    (length(azurerm_linux_web_app.api) > 0 ? "https://${azurerm_linux_web_app.api[0].default_hostname}" : "No new App Service URL available")
}

# Output the App Service name
output "app_service_name" {
  value = var.app_service_exists == "true" ?
    (length(azurerm_linux_web_app.existing_imported) > 0 ? azurerm_linux_web_app.existing_imported[0].name : "${var.app_name}-api") : 
    (length(azurerm_linux_web_app.api) > 0 ? azurerm_linux_web_app.api[0].name : "No App Service")
}

# Update role assignment to work with both resource types
resource "azurerm_role_assignment" "acr_pull" {
  count = length(data.azurerm_container_registry.existing) > 0 ?
    (var.app_service_exists == "true" ?
      (length(azurerm_linux_web_app.existing_imported) > 0 ? 1 : 0) :
      (length(azurerm_linux_web_app.api) > 0 ? 1 : 0)
    ) : 0

  scope                = data.azurerm_container_registry.existing[0].id
  role_definition_name = "AcrPull"
  principal_id         = var.app_service_exists == "true" ? 
    azurerm_linux_web_app.existing_imported[0].identity[0].principal_id : 
    azurerm_linux_web_app.api[0].identity[0].principal_id

  depends_on = [azurerm_linux_web_app.api, azurerm_linux_web_app.existing_imported]
}