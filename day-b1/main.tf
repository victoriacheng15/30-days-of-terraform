terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# The null provider does not create cloud infrastructure.
# It is useful for learning provider initialization, planning, apply, and state.
resource "null_resource" "state_probe" {
  triggers = {
    lab_name    = var.lab_name
    environment = var.environment
  }
}
