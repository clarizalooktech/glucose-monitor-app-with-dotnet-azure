variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "australiasoutheast"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}