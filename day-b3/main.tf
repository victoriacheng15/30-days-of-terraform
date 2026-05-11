terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# This resource will demonstrate idempotency.
# As long as 'triggers' don't change, 'tofu apply' does nothing.
resource "null_resource" "reconciliation_demo" {
  triggers = {
    content = var.content
  }
}

# A resource that would be "drifted" if the outside world changed it,
# but OpenTofu will try to pull it back to this configuration.
resource "null_resource" "idempotency_check" {
  triggers = {
    stable_value = "constant"
  }
}
