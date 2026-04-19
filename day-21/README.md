# Day 21: Azure Policy as Code

## Introduction

Day 21 focuses on governance. You define custom Azure policies, assign them at tenant scope, and enforce organizational guardrails that prevent non-compliant resources from being created.

This day is about answering: **how do we prevent mistakes at the infrastructure layer?**

## Key Concepts

- **Policy Definition:** A rule (in JSON) that evaluates resources against conditions.
- **Policy Assignment:** Activates a policy definition at a specific scope (subscription, management group, or tenant).
- **Effects:** Deny (block creation), Audit (log only), Modify (auto-fix), or DeployIfNotExists (auto-remediate).
- **Parameters:** Make policy definitions reusable by parameterizing allowed values (e.g., region list).

---

## Checklist

- [x] Define a "Naming Convention" policy requiring VMs to start with `vm-`.
- [x] Define an "Allowed Locations" policy restricting deployments to approved regions.
- [x] Assign both policies at tenant scope with deny effect.
- [x] Provide KQL-ready lab steps for testing policy enforcement.

---

## Lab: Enforce Naming and Region Guardrails

In this lab, you provision two custom policies and test compliance.

### Steps

1. Initialize the directory with `tofu init`.
2. Review `main.tf`:
   - `azurerm_policy_definition.allowed_locations` for region constraints.
   - `azurerm_policy_definition.naming_convention` for VM naming patterns.
   - `azurerm_subscription_policy_assignment` to activate both policies at subscription scope.
3. Run `tofu apply`.
4. Wait 5–15 minutes for policies to become active (Azure enforcement delay).
5. View your policies:
   ```bash
   az policy definition list --query "[?policyType=='Custom'].{Name:displayName, Id:id}"
   az policy assignment list --query "[].{Name:name, Scope:scope}"
   ```
6. Test location policy (should fail):
   ```bash
   az group create --name "test-rg-policy" --location "germanywestcentral"
   ```
   Expected: Policy denial error.

7. Check policy compliance in Azure Portal:
   - Go to **Policy** → **Compliance**.
   - View your assignments and compliance status.

---

*Back to [Main README](../README.md)*
