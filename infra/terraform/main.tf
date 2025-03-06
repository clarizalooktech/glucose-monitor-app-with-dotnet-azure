provider "azurerm" {
  features {}
  subscription_id = "xxxxxxx-aabd-cbc8131fbd94"
  tenant_id       = "xxxxx-a5c0-xxxxx-a4c7-xxx77a98a"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "asp" {
  name                = "glucose-monitor-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux" # Or "Windows"
  sku_name            = var.app_service_plan_sku_name
}

resource "azurerm_linux_web_app" "app" {
  name                = "glucose-monitor-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name # Use variable
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
}

resource "azurerm_storage_container" "sc" {
  name                  = var.storage_container_name # Use variable
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}