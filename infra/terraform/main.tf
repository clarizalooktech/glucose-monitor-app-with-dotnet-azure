provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  resource_provider_registrations = "none"
}

# Check if resource group exists
data "azurerm_resource_group" "existing" {
  count = var.create_infrastructure ? 0 : 1
  name  = var.resource_group_name
}

# Create resource group only if it doesn't exist and create_infrastructure is true
resource "azurerm_resource_group" "rg" {
  count    = var.create_infrastructure ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

# Local to reference the correct resource group properties
locals {
  # Use simple conditionals that are easier to parse
  resource_group_name = var.create_infrastructure ? (
    length(azurerm_resource_group.rg) > 0 ? azurerm_resource_group.rg[0].name : var.resource_group_name
  ) : (
    length(data.azurerm_resource_group.existing) > 0 ? data.azurerm_resource_group.existing[0].name : var.resource_group_name
  )

  resource_group_location = var.create_infrastructure ? (
    length(azurerm_resource_group.rg) > 0 ? azurerm_resource_group.rg[0].location : var.location
  ) : (
    length(data.azurerm_resource_group.existing) > 0 ? data.azurerm_resource_group.existing[0].location : var.location
  )
}