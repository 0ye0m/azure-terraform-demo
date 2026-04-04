terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {
  name = "rg-om-demo-1"
  location = "East Asia"
}

resource "azurerm_storage_account" "demo_sa" {
  name                     = "omstorage992211"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_static_web_app" "demo_swa" {
  name                = "om-static-demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = "East Asia"
  sku_tier            = "Free"
  sku_size            = "Free"
}