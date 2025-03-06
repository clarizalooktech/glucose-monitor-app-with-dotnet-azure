variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "glucose-monitor-rg"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US"
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