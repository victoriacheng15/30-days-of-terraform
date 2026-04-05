# Day 08

## Remote State: The Distributed Source of Truth

**Remote State** is a central place to store your `.tfstate` file, allowing multiple engineers to collaborate on the same infrastructure without overwriting each other's changes.

## Why use Remote State?

1. **Collaboration:** All team members see the same infrastructure state.
2. **State Locking:** Prevents two people from running `tofu apply` at the exact same time (which would corrupt your resources).
3. **Security:** State files often contain sensitive information (passwords, keys). Storing them in a secure, encrypted Azure Storage container is much safer than keeping them on your laptop.
4. **Availability:** If your laptop breaks, your infrastructure state is still safe in the cloud.

---

## Checklist

- [x] Create a "Backend" Resource Group and Storage Account (The "State Bucket").
- [x] Configure the `terraform { backend "azurerm" { ... } }` block in your code.
- [x] Run `tofu init` to migrate your local state to the cloud.
- [x] Observe how OpenTofu automatically creates a `lock` file in the storage account during an `apply`.

---

## Lab: Migrating to the Cloud

In this lab, you will create a storage account to hold your state and then "move" your configuration into it.

### Steps

1. Create the backend infrastructure (Resource Group, Storage Account, Container).
2. Update your `main.tf` to include the `backend "azurerm"` block.
3. Run `tofu init`. OpenTofu will ask: *"Do you want to copy existing state to the new backend?"* Say **yes**.
4. Verify the `.tfstate` file is now in your Azure Storage container.

---
*Back to [Main README](../README.md)*
