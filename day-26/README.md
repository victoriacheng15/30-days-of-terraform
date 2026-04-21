# Day 26: Testing with `tofu test`

## Introduction

Day 26 focuses on validating OpenTofu configurations before deployment. You use native tests to verify infrastructure behavior and security baselines automatically.

This day is about answering: **how do we prove infrastructure quality before apply?**

## Key Concepts

- **`tofu test`:** Native OpenTofu test runner for plan/apply assertions.
- **Assertions:** Validate outputs and resource attributes automatically.
- **Shift-left validation:** Catch configuration issues in CI before infrastructure is created.

---

## Checklist

- [x] Add `main.tftest.hcl` with plan-based assertions.
- [x] Validate output values and key security settings in automated tests.
- [x] Add a second test run with overridden variables (`environment = "prod"`).
- [x] Run multiple `tofu test` assertions for defaults and overridden inputs.
- [x] Keep the day self-contained and runnable with standard OpenTofu workflow.

---

## Lab: Test Infrastructure with `tofu test`

In this lab, you run automated tests against one OpenTofu configuration.

### Steps

1. Initialize the directory with `tofu init`.
2. Review `main.tf` and `outputs.tf`:
   - Storage account enforces TLS 1.2, HTTPS-only traffic, and private container access.
   - `security_settings` output exposes values used by test assertions.
3. Review `main.tftest.hcl`:
   - `plan_defaults` validates default output values and security baselines.
   - `plan_with_prod_environment` validates overridden variables and tag behavior.
4. Run `tofu test`.
5. **Validation:**

   ```bash
   tofu test
   tofu test -filter=plan_with_prod_environment
   ```

6. Confirm both `tofu test` runs pass.

---
*Back to [Main README](../README.md)*
