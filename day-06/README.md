# Day 06

## Data Sources: "Reading" from the Cloud

**Data Sources** are the "Read-Only" mode of OpenTofu. They allow you to fetch information about resources that already exist in the cloud but are **not managed** by your current OpenTofu configuration.

- **Managed Resource (`resource`):** You create, update, and delete it.
- **Data Source (`data`):** You only **look at it** to get its attributes (like an ID, a CIDR block, or a status).

## Why use Data Sources?

1. **Shared Infrastructure:** Your Networking team built the VNet, and you just need to put your VM inside one of their subnets.
2. **Environment Details:** You need to know the current Azure Subscription ID or the name of the user who is running the command.
3. **Discovery:** You need to find the latest "Golden Image" (AMI or Azure Image) to use for a new Virtual Machine.

---

## Checklist

- [x] Use a `data "azurerm_subscription" "current" {}` block to fetch your current account details.
- [x] Use a `data "azurerm_virtual_network" "example"` block to query an existing network.
- [x] Surface a data source's attribute (like `id`) in an `output` block.
- [x] Understand that a `data` source will **fail** if it cannot find the resource it is looking for.

---

## Lab: Query an Existing VNet

In this lab, you will learn how to "peek" into your Azure account to find existing resources.

### Steps

1. Create a `day-06/main.tf` file (provided in this directory).
2. The `main.tf` will first **create** a VNet (so you have something to look at).
3. Then, it will use a `data` source to "find" that same VNet and get its unique Azure ID.
4. Run `tofu init`.
5. Run `tofu apply`.
6. Observe the outputs—one output comes from the `resource`, and the other comes from the `data` source. They should match!
7. **The "Broken" Test:** Try to change the `name` in the `data` source block to something that doesn't exist (like `vnet-fake-123`) and run `tofu plan`. Notice how it fails because it can't find the resource.

---
*Back to [Main README](../README.md)*
