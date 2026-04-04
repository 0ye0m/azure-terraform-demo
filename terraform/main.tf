terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
}

# Random for unique storage name
resource "random_id" "rand" {
  byte_length = 4
}

# Resource Group
resource "azurerm_resource_group" "demo" {
  name     = "rg-om-demo-1"
  location = "East Asia"
}

# Storage Account (unique name)
resource "azurerm_storage_account" "demo_sa" {
  name                     = "omstorage${random_id.rand.hex}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Static Web App (use safe region)
resource "azurerm_static_web_app" "demo_swa" {
  name                = "om-static-demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = "East Asia"
  sku_tier            = "Free"
  sku_size            = "Free"
}