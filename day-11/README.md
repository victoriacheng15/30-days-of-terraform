# Day 11: Identity and RBAC (Role-Based Access Control)

## Introduction

In modern cloud architecture, we move away from sharing passwords and keys. Instead, we use **Managed Identities**. 

A **Managed Identity** provides an identity for applications to use when connecting to resources that support Azure AD (now Microsoft Entra ID) authentication. The best part? Azure manages the identity for you—there are **no secrets to rotate or leak**.

## What is RBAC?

**Role-Based Access Control (RBAC)** is the system you use to manage who has access to Azure resources, what they can do with those resources, and what areas they have access to.

It consists of three elements:
1.  **Security Principal:** The "Who" (e.g., your Managed Identity).
2.  **Role Definition:** The "What" (e.g., `Storage Blob Data Reader`).
3.  **Scope:** The "Where" (e.g., a specific Storage Account).

## The Principle of Least Privilege

Always assign the **minimum** permissions required for a task. 
- **BAD:** Giving a VM `Owner` access to a subscription.
- **GOOD:** Giving a VM `Storage Blob Data Reader` access to a single container.

---

## Checklist

- [x] Create a `User Assigned Managed Identity`.
- [x] Provision a `Storage Account` for testing.
- [x] Assign the `Storage Blob Data Reader` role to the Identity at the Storage Account scope.
- [x] Use `azurerm_role_assignment` to link the identity to the role.

---

## Lab: Securing Identity

In this lab, you will create a "Self-Secured" identity that can read data from a specific storage account.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf` to see how the role is assigned to the identity.
3. Run `tofu apply` to deploy the resources.
4. Inspect the IAM (Access Control) tab in the Azure Portal to see your Identity listed.

---
*Back to [Main README](../README.md)*
