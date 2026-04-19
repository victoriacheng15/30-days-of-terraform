# Day 22: Cost Management and Optimization

## Introduction

Day 22 focuses on cost governance. You set up budget alerts to track spending and enforce mandatory tagging policies that enable cost allocation and chargeback across teams.

This day is about answering: **how do we control costs and allocate them transparently?**

## Key Concepts

- **Budget Alerts:** Notifications when spending exceeds thresholds (e.g., 80% of monthly budget).
- **Cost Allocation Tags:** Mandatory tags (`costCenter`, `environment`, `owner`) for tracking and chargeback.
- **Policy Enforcement:** Deny resource creation if mandatory tags are missing.
- **Forecasted vs. Actual:** Alerts can trigger on forecasted spending (predictive) or actual (post-facto).

---

## Checklist

- [x] Create a subscription-level monthly budget alert.
- [x] Configure alert thresholds (forecasted at 80%, actual at 100%).
- [x] Define a "Mandatory Tags" policy requiring `costCenter`, `environment`, `owner` tags.
- [x] Assign the policy at subscription scope with deny effect.
- [x] Provide lab steps for testing tag enforcement and viewing budget data.

---

## Lab: Budget Alerts + Tag Enforcement

In this lab, you provision cost governance controls and test tag compliance.

### Steps

1. Initialize the directory with `tofu init`.
2. Review `main.tf`:
   - `azurerm_consumption_budget_subscription` for monthly budget tracking.
   - `azurerm_policy_definition.mandatory_tags` for tag governance.
   - `azurerm_subscription_policy_assignment` to enforce the tag policy.
3. Update `variables.tf` with your email address for budget alerts.
4. Run `tofu apply`.
5. Wait 5–15 minutes for policy assignment to activate.
6. View budget and cost analysis in Azure Portal:
   - Go to **Cost Management** → **Budgets**.
   - View the monthly budget alert and spending trends.
7. Check tag policy compliance:
   ```bash
   az policy assignment list --query "[].{Name:name, Scope:scope}"
   ```
8. Test tag enforcement by attempting to create a resource group without mandatory tags (should fail once policy is active).

---

*Back to [Main README](../README.md)*
