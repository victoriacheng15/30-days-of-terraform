# day-02/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

output "auth_status" {
  value = "Azure provider is initialized. Run 'tofu plan' to verify cloud authentication."
}
