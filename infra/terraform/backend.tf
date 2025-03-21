/*
terraform {
  backend "azurerm" {
    resource_group_name  = "glucose-monitor-rg"
    storage_account_name = "glucosemonitorstorage"
    container_name       = "glucosemonitorstoragecontainer"
    key                  = "terraform.tfstate"
  }
}
*/