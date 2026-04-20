# Day 25: Advanced Expressions (`count`, `for_each`, dynamic blocks)

## Introduction

Day 25 focuses on reducing duplication in OpenTofu configurations. You use advanced expressions to scale infrastructure patterns with less code and clearer intent.

This day is about answering: **how do we model many resources without copy-paste?**

## Key Concepts

- **`for_each`:** Create resources from maps or sets with stable keys.
- **`count`:** Toggle optional resources using numeric conditions.
- **`dynamic` blocks:** Generate repeated nested configuration blocks (for example NSG rules).
- **Composable inputs:** Use structured variables (maps/objects/lists) to model infrastructure at scale.

---

## Checklist

- [x] Use `for_each` to create multiple VNets from a map.
- [x] Use `for_each` to create subnets from nested VNet subnet definitions.
- [x] Use a `dynamic` block to generate NSG security rules.
- [x] Use `count` to optionally create a diagnostics storage account.
- [x] Expose outputs that show created resources by key.

---

## Lab: Refactor to Expression-Driven Infrastructure

In this lab, you deploy network infrastructure using maps, loops, and conditional resources.

### Steps

1. Initialize the directory with `tofu init`.
2. Review `variables.tf`:
   - `vnets` map drives multi-VNet and subnet creation.
   - `nsg_rules` list drives NSG `dynamic "security_rule"` rendering.
   - `create_diagnostics_storage` toggles optional resource creation.
3. Review `main.tf`:
   - `azurerm_virtual_network.main` uses `for_each`.
   - `azurerm_subnet.main` uses flattened subnet data with `for_each`.
   - `azurerm_network_security_group.main` uses `dynamic "security_rule"`.
   - `azurerm_storage_account.diagnostics` uses `count`.
4. Run `tofu apply`.
5. **Validation:**

   ```bash
   tofu output
   az network vnet list --resource-group rg-day25-expressions --query "[].name"
   az network nsg list --resource-group rg-day25-expressions --query "[].name"
   ```

6. Set `create_diagnostics_storage = false`, re-run `tofu plan`, and confirm the storage account is no longer planned.

---
*Back to [Main README](../README.md)*
