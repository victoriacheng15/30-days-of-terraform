# Day 04

## OpenTofu Lifecycle Commands

The core lifecycle of an OpenTofu deployment consists of four primary stages. Understanding these commands is essential for managing infrastructure reliably.

- **`tofu init`:** Initializes the working directory. It downloads providers, modules, and sets up the backend for state management.
- **`tofu plan`:** Creates an execution plan. It compares the current state of your infrastructure against your HCL code and identifies the actions (create, update, delete) needed to reach the desired state.
- **`tofu apply`:** Executes the plan. This is the command that actually makes changes to your cloud environment.
- **`tofu destroy`:** Tears down all managed infrastructure defined in your configuration.

## Understanding the State File (`terraform.tfstate`)

The **State File** is the "source of truth" for OpenTofu. It maps your HCL resource definitions to real-world resources in Azure or AWS.

- **Metadata:** It stores resource IDs, IP addresses, and other attributes returned by the cloud provider.
- **Refresh:** Before every `plan` or `apply`, OpenTofu runs a "refresh" to ensure the state file matches the actual state of the cloud.
- **Security:** State files can contain sensitive information (like database passwords in plaintext). **Always protect your state file and use remote backends for production.**

## Targeted Operations and Tainting

Sometimes you need more granular control over your infrastructure:

- **Targeted Apply (`-target`):** Allows you to apply changes to a specific resource rather than the entire configuration. Use this sparingly as it can lead to configuration drift.
- **Tainting (`tofu taint`):** Marks a specific resource for recreation during the next `apply`. This is useful if a resource is in a "bad state" (e.g., a VM that didn't provision correctly) and you want OpenTofu to delete and recreate it.
  - *Note:* In newer versions of OpenTofu, `tofu apply -replace="resource_address"` is the preferred way to achieve this.

---

## Checklist

- [x] Run `tofu init` to prepare the environment.
- [x] Run `tofu plan` and review the execution plan.
- [x] Run `tofu apply` and verify the creation of the resource.
- [x] Manually inspect the `terraform.tfstate` file (it is JSON).
- [x] Use `tofu taint` (or `-replace`) to mark a resource for recreation.
- [x] Run `tofu destroy` to clean up.

---

## Lab: Lifecycle and State Exploration

In this lab, you will walk through the full lifecycle of a resource, learn how to interact with the state file, and practice targeted operations.

### Steps

1. Create a `day-04/main.tf` file (provided in this directory).
2. Run `tofu init` and `tofu plan`.
3. Run `tofu apply` to create the resources.
4. Locate the `terraform.tfstate` file in your directory and open it in a text editor to identify your resource attributes.
5. **Targeted Apply:** Change a tag or a trigger in `main.tf`, then run `tofu apply -target=null_resource.example` to update only that specific resource.
6. **Tainting:** Run `tofu taint null_resource.example` (or `tofu apply -replace="null_resource.example"`) to mark it for recreation.
7. Run `tofu plan` and observe that OpenTofu now wants to "replace" the resource.
8. Run `tofu destroy` to clean up everything.

---
*Back to [Main README](../README.md)*

