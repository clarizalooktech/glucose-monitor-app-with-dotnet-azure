# Get existing App Service Plan if it exists
data "azurerm_service_plan" "existing" {
  count               = var.app_service_plan_exists ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
  
  depends_on = [azurerm_resource_group.rg]
}

# Create App Service Plan only if it doesn't exist
resource "azurerm_service_plan" "app_service_plan" {
  count               = var.app_service_plan_exists ? 0 : 1
  name                = "${var.app_name}-plan"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  os_type             = "Linux"
  sku_name            = "B1"
  
  depends_on = [azurerm_resource_group.rg]
}

# Use either the existing or new App Service Plan
locals {
  service_plan_id = var.app_service_plan_exists ? data.azurerm_service_plan.existing[0].id : azurerm_service_plan.app_service_plan[0].id
}

# Data source to get existing App Service if it exists
data "azurerm_linux_web_app" "existing_api" {
  count               = var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
  
  depends_on = [azurerm_resource_group.rg]
}

# App Service for API - Create only if it doesn't exist
resource "azurerm_linux_web_app" "api" {
  count               = var.app_service_exists ? 0 : 1
  name                = "${var.app_name}-api"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  service_plan_id     = local.service_plan_id

  site_config {
    always_on = true
    
    application_stack {
      docker_image_name        = "${var.app_name}-api:latest"
      docker_registry_url      = "https://${local.acr_login_server}"
      docker_registry_username = local.acr_admin_username
      docker_registry_password = local.acr_admin_password
    }
    
    ftps_state = "Disabled"
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }
  
  depends_on = [
    azurerm_service_plan.app_service_plan,
    azurerm_container_registry.acr
  ]
}

# Local to get the correct App Service identity
locals {
  app_service_principal_id = var.app_service_exists ? data.azurerm_linux_web_app.existing_api[0].identity[0].principal_id : azurerm_linux_web_app.api[0].identity[0].principal_id
}

# Assign AcrPull role to App Service managed identity
resource "azurerm_role_assignment" "acr_pull" {
  count                = var.skip_role_assignment ? 0 : 1
  scope                = var.create_infrastructure ? azurerm_container_registry.acr[0].id : data.azurerm_container_registry.existing[0].id
  role_definition_name = "AcrPull"
  principal_id         = local.app_service_principal_id
  
  depends_on = [
    azurerm_linux_web_app.api,
    data.azurerm_linux_web_app.existing_api
  ]
}

# Output the App Service URL
output "api_url" {
  value = var.app_service_exists ? "https://${data.azurerm_linux_web_app.existing_api[0].default_hostname}" : "https://${azurerm_linux_web_app.api[0].default_hostname}"
}

# Output the App Service name
output "app_service_name" {
  value = var.app_service_exists ? data.azurerm_linux_web_app.existing_api[0].name : azurerm_linux_web_app.api[0].name
}