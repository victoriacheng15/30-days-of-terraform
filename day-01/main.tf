terraform {
  required_providers {
    null = {
      source = "opentofu/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "hello_world" {
  provisioner "local-exec" {
    command = "echo 'Hello Opentofu! Day 01 enviornment verified.'"
  }
}

output "status" {
  value = "Success! Opentofu is initialized and the null resource is ready."
}