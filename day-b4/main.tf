terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# This resource creates a local file.
# Because it exists on your disk, you can "drift" it manually.
resource "local_file" "drift_demo" {
  filename = "${path.module}/${var.filename}"
  content  = var.desired_content
}
