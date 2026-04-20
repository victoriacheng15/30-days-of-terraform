terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = merge(
    {
      environment = var.environment
      project     = "30-days-of-opentofu"
      day         = "24"
    },
    var.common_tags
  )
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

module "storage_account" {
  source = "./modules/storage-account"

  name_prefix              = var.storage_account_name_prefix
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  environment              = var.environment
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  tags                     = local.tags
}
