# day-04/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. A simple Azure Resource Group
resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. A primary null resource for lifecycle testing
resource "null_resource" "example" {
  triggers = {
    location = var.location
  }

  provisioner "local-exec" {
    command = "echo 'Example resource created for ${var.location}'"
  }
}

# 3. A secondary null resource to practice targeted operations
resource "null_resource" "secondary" {
  triggers = {
    status = "active"
  }

  provisioner "local-exec" {
    command = "echo 'Secondary resource created.'"
  }
}
