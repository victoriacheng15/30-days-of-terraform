# day-05/main.tf

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

# 1. Base Resource
resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. Implicit Dependency
# This resource implicitly depends on the Resource Group because it references azurerm_resource_group.lab.name.
resource "null_resource" "implicit" {
  triggers = {
    # Implicitly tied to the Resource Group name
    resource_group = azurerm_resource_group.lab.name
  }

  provisioner "local-exec" {
    command = "echo 'Implicit dependency resource created for ${azurerm_resource_group.lab.name}'"
  }
}

# 3. Explicit Dependency
# This resource has an explicit 'depends_on' block, even though it doesn't directly reference another resource.
resource "null_resource" "explicit" {
  # Explicitly depends on the implicit resource
  depends_on = [null_resource.implicit]

  provisioner "local-exec" {
    command = "echo 'Explicit dependency resource created after the implicit resource.'"
  }
}
