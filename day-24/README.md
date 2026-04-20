# Day 24: Modules (Local Only)

## Introduction

After building complete Azure stacks in previous days, Day 24 shifts to **reusability**. You break repeated infrastructure into modules and consume those modules from a clean root configuration.

This day is about answering: **how do we scale IaC without duplicating code?**

## Key Concepts

- **Module Boundaries:** Group related resources into focused units (for example `resource-group`, `storage-account`).
- **Input/Output Contracts:** Expose configurable variables and stable outputs for consumers.
- **Local Sources First:** Use `./modules/...` during development for fast iteration.
- **Local Module Sources:** Keep module sources as relative paths (`./modules/...`) for this lab.

---

## Checklist

- [x] Create reusable `resource-group` and `storage-account` modules.
- [x] Refactor root configuration to consume those modules.
- [x] Add variable validation and secure defaults.
- [x] Expose clean outputs from modules and root.
- [x] Keep module consumption local-only (`./modules/...`) with no registry dependency.

---

## Lab: Build and Consume Reusable Modules

In this lab, you create reusable modules and deploy infrastructure from a root module that consumes them.

### Steps

1. Initialize the directory with `tofu init`.

2. Review `main.tf`:
   - `modules/resource-group/`
   - `modules/storage-account/`
   - Observe how root module calls each child module with explicit inputs.
3. Run `tofu apply`.
4. **Validation:**

   ```bash
   tofu output
   az group show --name rg-day24-modules
   az storage account show --resource-group rg-day24-modules --name <your-storage-account-name>
   ```

5. Confirm both module blocks in `main.tf` use local paths:
   - `source = "./modules/resource-group"`
   - `source = "./modules/storage-account"`

---

*Back to [Main README](../README.md)*
