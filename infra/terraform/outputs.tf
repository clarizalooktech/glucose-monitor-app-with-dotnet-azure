output "resource_group_name" {
  value = local.resource_group_name
}

output "acr_name" {
  value = var.acr_name
}

output "acr_login_server" {
  value = local.acr_login_server
}

output "acr_admin_username" {
  value = local.acr_admin_username
}

output "acr_admin_password" {
  value     = local.acr_admin_password
  sensitive = true
}