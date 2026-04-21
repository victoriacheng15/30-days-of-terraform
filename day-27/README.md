# Day 27: CI Validation with GitHub Actions

## Introduction

Day 27 focuses on lightweight CI checks for OpenTofu with GitHub Actions. The workflow runs formatting and validation to catch issues early.

This day is about answering: **how do we enforce IaC quality checks in CI?**

## Key Concepts

- **Fmt check:** Enforce consistent OpenTofu formatting in pull requests.
- **Validate check:** Verify configuration syntax and references before deployment.
- **Fast feedback:** Keep CI minimal for quick pass/fail signals.
- **PR gating:** Block merges when IaC quality checks fail.

---

## Checklist

- [x] Add a GitHub Actions workflow at `.github/workflows/ci.ymal`.
- [x] Run `tofu fmt -check -recursive` in CI.
- [x] Run `tofu validate` in CI.
- [x] Trigger workflow on pull requests and pushes to `main`.
- [x] Keep infra example in `day-27/` for validation tests.

---

## Lab: Build OpenTofu CI Validation Workflow

In this lab, you configure a GitHub Actions workflow that runs only format and validation checks.

### Steps

1. Initialize the directory with `tofu init`.
2. Review workflow file `.github/workflows/ci.ymal`:
   - `checks` job runs `tofu fmt -check -recursive`.
   - `checks` job validates every `day-*` folder that contains `.tf` files.
3. Open a pull request and confirm the workflow runs.
4. **Validation:**

   ```bash
   tofu fmt -check -recursive
   tofu init -input=false -no-color
   tofu validate -no-color
   ```

---
*Back to [Main README](../README.md)*
