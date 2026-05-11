output "execution_order" {
  value = [
    "1. Parent: ${null_resource.parent.id}",
    "2. Implicit Child: ${null_resource.implicit_child.id}",
    "3. Explicit Child: ${null_resource.explicit_child.id}"
  ]
}
