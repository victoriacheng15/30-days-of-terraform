terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# The Root Resource
resource "null_resource" "parent" {
  triggers = {
    prefix = var.prefix
  }
}

# Implicit Dependency: Reference to another resource attribute
resource "null_resource" "implicit_child" {
  triggers = {
    parent_id = null_resource.parent.id
  }
}

# Explicit Dependency: Forced ordering without attribute reference
resource "null_resource" "explicit_child" {
  depends_on = [null_resource.implicit_child]

  triggers = {
    prefix = var.prefix
  }
}

# Lifecycle Demo: Create Before Destroy
# This changes the graph walk order for replacements
resource "null_resource" "lifecycle_demo" {
  triggers = {
    prefix = var.prefix
  }

  lifecycle {
    create_before_destroy = true
  }
}
