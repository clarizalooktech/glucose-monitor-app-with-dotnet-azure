# App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  count               = var.create_infrastructure && !var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan (pay-as-you-go) and can use containers
}

# App Service for API
resource "azurerm_linux_web_app" "api" {
  count               = var.create_infrastructure && !var.app_service_exists ? 1 : 0
  name                = "${var.app_name}-api"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.app_service_plan[0].id

  site_config {
    application_stack {
      docker_image     = "${azurerm_container_registry.acr.login_server}/glucose-monitor-api:latest"
      docker_image_tag = "latest"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = azurerm_container_registry.acr.admin_password
  }

  identity {
    type = "SystemAssigned"
  }
}

# Output the App Service URL
output "api_url" {
  value = var.create_infrastructure ? "https://${azurerm_linux_web_app.api[0].default_hostname}" : "No new App Service created"
}

# Output the App Service name
output "app_service_name" {
  value = var.create_infrastructure ? azurerm_linux_web_app.api[0].name : data.azurerm_linux_web_app.existing_api[0].name
}

# Data source to get existing App Service if it exists
data "azurerm_linux_web_app" "existing_api" {
  count               = var.create_infrastructure ? 0 : 1
  name                = "${var.app_name}-api"
  resource_group_name = azurerm_resource_group.rg.name
}