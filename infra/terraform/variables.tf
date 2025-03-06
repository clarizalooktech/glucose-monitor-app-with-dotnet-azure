variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "glucose-monitor-rg"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "Australia Southeast"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "glucose-monitor-asp"
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
  default     = "glucose-monitor-app"
}

variable "storage_account_name" {
  description = "The name of the Storage Account"
  type        = string
  default     = "glucosemonitorstorage"
}

variable "storage_container_name" {
  description = "The name of the Storage Container"
  type        = string
  default     = "tfstate"
}

variable "app_service_plan_sku_name" {
  description = "The App Service Plan SKU name (e.g., F1, S1, P1v2)."
  default     = "F1"
}