# Day 09: VNet and Subnet Design

## The Virtual Backbone

A **Virtual Network (VNet)** is your own private network in Azure. It provides isolation, segmentation, and the ability for resources (like VMs or Databases) to communicate securely.

## CIDR Basics (The "Address Space")

When you create a VNet, you must specify an address space using **CIDR notation** (e.g., `10.0.0.0/16`).

- `/16` provides 65,536 IP addresses.
- `/24` provides 256 IP addresses (minus 5 reserved by Azure).

### Subnet Segmentation

Instead of putting everything in one big network, we split the VNet into **Subnets**. This allows for:

1. **Security:** Applying different firewall rules (NSGs) to each tier.
2. **Organization:** Separating web servers from databases.
3. **Routing:** Controlling how traffic flows between tiers.

---

## Checklist

- [x] Define a VNet with a `10.0.0.0/16` address space.
- [x] Create a `frontend` subnet (`10.0.1.0/24`).
- [x] Create a `backend` subnet (`10.0.2.0/24`).
- [x] Create a `database` subnet (`10.0.3.0/24`).
- [x] Use variables for the address space and subnet prefixes.

---

## Lab: Building the Network

In this lab, you will provision the networking foundation for a 3-tier application.

### Steps

1. Initialize your directory with `tofu init`.
2. Review the `variables.tf` to understand the CIDR ranges.
3. Run `tofu apply` to build the network.
4. Inspect the Azure Portal or use `az network vnet show` to verify the subnets.

---
*Back to [Main README](../README.md)*
