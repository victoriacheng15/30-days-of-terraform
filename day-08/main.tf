terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # THE BACKEND BLOCK
  # Note: Variables are NOT allowed here. 
  # You must fill these in manually with the output from setup-backend.sh
  backend "azurerm" {
    resource_group_name  = "rg-tofu-state-mgmt"
    storage_account_name = "tofustate17871"
    container_name       = "tfstate"
    key                  = "day-08.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Just a dummy resource to verify that the state is being saved remotely.
resource "azurerm_resource_group" "remote_state_test" {
  name     = "rg-remote-state-lab"
  location = "West US 2"

  tags = {
    ManagedBy = "OpenTofu"
    Day       = "08"
  }
}
