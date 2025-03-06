output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "app_service_plan_name" {
  value = azurerm_service_plan.asp.name
}

output "app_service_name" {
  value = azurerm_linux_web_app.app.name
}

output "app_service_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_container_name" {
  value = azurerm_storage_container.sc.name
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}