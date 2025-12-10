terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.55.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  
  required_version = ">= 1.2.0"
}

provider "azurerm" {
  subscription_id = "4dd8cf87-5a76-49f4-8de7-2575f38c63ba"
  client_id       = "a2417c95-095e-40fb-b2eb-a893b69cf28a"
  client_secret   = "${var.client_secret}"
  tenant_id       = "16e0f386-7dc5-4367-bff0-35961aca0ac1"
  features {}
}
