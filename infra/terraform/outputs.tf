output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "app_service_plan_name" {
  value = azurerm_app_service_plan.asp.name
}

output "app_service_name" {
  value = azurerm_app_service.app.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_container_name" {
  value = azurerm_storage_container.sc.name
}