variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "Azure region where resources should be created"
  type        = string
  default     = "eastus"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "create_infrastructure" {
  description = "Whether to create new infrastructure or use existing resources"
  type        = bool
  default     = false
}

variable "app_name" {
  description = "Base name for resources"
  type        = string
  default     = "glucose-monitor"
}

variable "app_service_exists" {
  description = "Whether the App Service already exists"
  type        = bool
  default     = false
}

variable "app_service_plan_exists" {
  description = "Whether the App Service Plan already exists"
  type        = bool
  default     = false
}

variable "skip_role_assignment" {
  description = "Skip role assignment during initial deployment"
  type        = bool
  default     = false
}

variable "acr_exists" {
  description = "Whether the ACR already exists"
  type        = bool
  default     = false
}

variable "static_web_app_exists" {
  description = "Whether the Static Web App already exists"
  type        = bool
  default     = false
}