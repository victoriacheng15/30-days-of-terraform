# Day 05

## Resource Dependency Model

OpenTofu manages resources by building a **Dependency Graph**. This graph determines the order in which resources are created, updated, or destroyed.

- **Implicit Dependencies:** These are automatically detected when one resource refers to an attribute of another. For example, assigning a Subnet ID to a VM's network interface creates an implicit dependency. OpenTofu "knows" it must create the Subnet first.
- **Explicit Dependencies (`depends_on`):** Used when OpenTofu cannot automatically detect a connection between resources. This is common when a resource depends on a side-effect (e.g., a script execution or a policy) that isn't reflected in its direct configuration.

## Understanding the Graph

- **Creation Order:** Resources with no dependencies are created first (in parallel if possible). Dependent resources follow.
- **Destruction Order:** Resources are destroyed in the reverse order of their creation to ensure clean tear-downs (e.g., the VM is deleted before the Subnet).

---

## Checklist

- [x] Demonstrate an **Implicit Dependency** by referencing one resource's attribute in another.
- [x] Demonstrate an **Explicit Dependency** using the `depends_on` meta-argument.
- [x] Run `tofu plan` and observe the resource creation order.
- [x] Run `tofu apply` and verify the execution sequence in the terminal.

---

## Lab: Dependency and Ordering

In this lab, you will build two resources with a dependency and observe how OpenTofu manages their execution order.

### Steps

1. Create a `day-05/main.tf` file (provided in this directory).
2. Review the `main.tf` to identify the implicit dependency (referencing the Resource Group name) and the explicit dependency (`depends_on`).
3. Run `tofu init`.
4. Run `tofu plan`. Notice how OpenTofu plans to create the Resource Group first.
5. Run `tofu apply`. Carefully watch the output to see the exact order of creation.
6. Run `tofu destroy` and observe that the order is reversed.

---
*Back to [Main README](../README.md)*
