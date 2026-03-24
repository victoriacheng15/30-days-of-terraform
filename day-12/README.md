# Day 12: Secrets and Azure Key Vault

## Introduction

In the past, developers stored secrets (like DB passwords or API keys) in `.env` files or hardcoded them in their code. This is **dangerous**. 

**Azure Key Vault** is a centralized cloud service for storing and managing sensitive information. It allows you to:
- **Secrets:** Store application passwords and connection strings.
- **Keys:** Manage encryption keys for your data.
- **Certificates:** Provision and manage SSL/TLS certificates.

## Identity-as-a-Key

Instead of using a password to "Unlock" the Key Vault, we use the **Managed Identity** from Day 11. 

By using **Access Policies** or **RBAC**, you can tell the Key Vault:
> *"Only allow the `id-app-reader` Identity to 'Get' secrets."*

This means your application code never needs to know a "Key Vault Password." It simply "is" who it "is," and Azure handles the authentication for you.

## Soft Delete and Purge Protection

One of the most important features of Key Vault is **Soft Delete**. If a secret is deleted (even accidentally), it is "hidden" for a retention period (usually 90 days) instead of being destroyed permanently. This prevents a single mistake from taking down your entire production system.

---

## Checklist

- [x] Provision an `Azure Key Vault`.
- [x] Enable `Soft Delete` (this is now a default requirement in Azure).
- [x] Store a `Secret` (e.g., `db-password`).
- [x] Assign the `Key Vault Secrets User` role to the Day 11 Identity.
- [x] Reference the secret in your Terraform config.

---

## Lab: Locking the Vault

In this lab, you will build a "Digital Safe" and give your Identity the combination.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf` to see how we reference the existing Identity.
3. Run `tofu apply` to deploy the Vault and Secret.
4. Try to view the secret via the Azure CLI (if you have permissions):
   ```bash
   az keyvault secret show --name db-password --vault-name <your-vault-name>
   ```

---
*Back to [Main README](../README.md)*
