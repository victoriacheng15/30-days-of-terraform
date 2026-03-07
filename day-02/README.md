# Day 02

## Provider Configuration

The `provider` block is the heart of OpenTofu's extensibility. It tells OpenTofu which API to talk to (e.g., Azure) and how to configure that connection.

- **Source Address:** Each provider has a unique source address (e.g., `hashicorp/azurerm`). OpenTofu pulls these from the **OpenTofu Registry**.
- **Version Pinning:** It is an architectural best practice to pin your provider versions using `version = "~> 4.0"`. This prevents breaking changes from being introduced during a routine `tofu init`.
- **Multiple Instances:** You can define multiple provider blocks for the same cloud using an `alias`. This is useful for multi-region or multi-subscription deployments.

## Authentication & Credentials

OpenTofu interacts with cloud providers using a **Credential Chain**. For local development, it leverages your existing CLI sessions:

- **Azure CLI:** Run `az login`. OpenTofu will automatically detect the active subscription and token from your Azure CLI cache.
- **Environment Variables:** For CI/CD, you should never hardcode secrets. Instead, use standard environment variables:
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`

## The Registry & Lock File

When you run `tofu init`, OpenTofu performs two critical tasks:

- **OpenTofu Registry:** It downloads the required provider binaries from `registry.opentofu.org`. This registry is a community-managed, open-source mirror of the provider ecosystem.
- **Dependency Lock File (`.terraform.lock.hcl`):** This file is generated during initialization. It records the exact version and a cryptographically secure hash (HMAC) of the provider binaries.
  - **Security:** It protects against supply-chain attacks by ensuring the provider binary hasn't been tampered with.
  - **Stability:** It ensures that every developer and CI/CD runner is using the exact same provider version. **Always commit this file to your repository.**

---

## Checklist

- [x] Verify `tofu` installation by running `tofu --version` inside the `nix-shell`.
- [x] Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
- [x] Authenticate your local session using `az login`.
- [x] Inspect the `.terraform.lock.hcl` file after running the lab below.

---

## Lab: Provider Authentication

In this lab, you will configure OpenTofu to authenticate with Azure. We will initialize the provider without creating any actual resources to confirm that your credentials are valid.

### Steps

1. Create a `day-02/main.tf` file.
2. Define the `required_providers` block for `azurerm`.
3. Run `tofu init` to download the provider and generate the lock file.
4. Run `tofu plan` to verify that OpenTofu can successfully authenticate with Azure.

---
*Back to [Main README](../README.md)*
