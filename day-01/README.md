# Day 01

## OpenTofu Overview & History

OpenTofu is an open-source version of Terraform, forked from Terraform v1.5.7 in August 2023. This fork was a response to HashiCorp's decision to move Terraform from an open-source license to a more restrictive "source-available" license.

- **Governance:** Managed by the **Linux Foundation**, ensuring that no single corporation controls the project's future.
- **Goal:** To provide a vendor-neutral, 100% open-source, and community-driven ecosystem for HCL-based infrastructure management.
- **Compatibility:** It is designed as a drop-in replacement for Terraform versions prior to 1.6, maintaining full support for existing providers and state files.

## License Audit: BSL vs. MPL

The primary difference between the two tools lies in their licensing philosophy:

| Feature | Terraform (v1.6+) | OpenTofu |
| :--- | :--- | :--- |
| **License** | **BSL 1.1** (Business Source License) | **MPL 2.0** (Mozilla Public License) |
| **Open Source?** | No (Source-available) | **Yes** (OSI-approved) |
| **Commercial Use** | Free for most, but restricts competitive services. | **Unrestricted** commercial use. |
| **Redistribution** | Highly restricted. | Allowed under MPL terms. |

## Declarative vs. Imperative IaC

Modern infrastructure management prioritizes **Declarative** over **Imperative** approaches:

- **Declarative (OpenTofu):** You define the *desired end state* (e.g., "I want a VPC with 3 subnets"). The tool calculates the necessary changes and handles dependencies and ordering. This makes it **idempotent**, meaning you can run it repeatedly with the same result.
- **Imperative (Bash/CLI):** You define the *specific steps* (e.g., "Create VPC; wait 10s; create subnet 1..."). This approach is harder to scale, prone to errors if a step fails, and does not natively track the "state" of your infrastructure.

---

## Checklist

- [x] Read the OpenTofu [Introduction](https://opentofu.org/docs/intro/).
- [x] Understand the differences between BSL and MPL licensing.
- [x] Contrast Declarative vs. Imperative approaches in your own words.
- [x] Complete the Lab below to verify your environment.

---

## Lab: Your First Resource

Write your first `main.tf` that creates a dummy resource using the `null` provider.

### Steps

1. Create a `day-01/main.tf` file.
2. Define a `null_resource` block.
3. Run `tofu init` to initialize the provider.
4. Run `tofu plan` to see the proposed changes.
5. (Optional) Run `tofu apply` to execute the local command.

---
*Back to [Main README](../README.md)*
