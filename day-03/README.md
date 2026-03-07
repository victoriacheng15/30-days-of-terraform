# Day 03

## HCL Syntax: Variables, Maps, Lists, and Outputs

The HashiCorp Configuration Language (HCL) is designed to be human-readable and machine-executable. Day 03 focuses on making your infrastructure "programmable" by using variables and outputs.

- **Variables (`variable`):** These are the inputs to your configuration. They allow you to reuse code for different environments (e.g., dev, staging, prod) without changing the core logic.
- **Maps (`map`):** Collections of key-value pairs. Ideal for tags or looking up values based on a key (e.g., mapping environment names to specific Azure regions).
- **Lists (`list`):** Ordered collections of values of the same type (e.g., a list of allowed IP addresses for a firewall).
- **Outputs (`output`):** These are the "return values" of your configuration. They surface information (like a Public IP or a Resource ID) after a successful deployment.

## Type Constraints & Validation

To build resilient infrastructure, you should always define the `type` of your variables. This ensures that OpenTofu catches errors (like passing a string to a number field) before it even talks to Azure.

- **Primitive Types:** `string`, `number`, `bool`.
- **Complex Types:** `list()`, `map()`, `object()`.
- **Validation Blocks:** You can add custom logic to variables to enforce business rules (e.g., "The VM size must be a Standard_B1s").

## OpenTofu Console

The `tofu console` is an interactive REPL (Read-Eval-Print Loop) for testing HCL expressions, functions, and variable interpolations without running a full `plan`.

- Use it to verify math: `1 + 5`.
- Use it to test string functions: `upper("azure")`.
- Use it to inspect your current variables: `var.location`.

---

## Checklist

- [x] Define variables for `location` and `resource_group_name`.
- [x] Create a `tags` map with default values.
- [x] Add a validation rule to a variable to restrict allowed values.
- [x] Use `tofu console` to evaluate at least three different HCL expressions. (e.g. `var.location`, `var.tags["owner"]`, etc)

---

## Lab: HCL Expressions and Variables

In this lab, you will practice defining variables with types and validation, and then use the OpenTofu console to interact with them.

### Steps

1. Create a `day-03/variables.tf` file with a `location` variable and a `tags` map.
2. Create a `day-03/outputs.tf` file to surface the values of your variables.
3. Create a `day-03/main.tf` that defines the `azurerm` provider.
4. Run `tofu init`.
5. Run `tofu console` and type `var.location` to see its value.
6. Try evaluating a complex expression in the console, such as `upper(var.location)`.

---
*Back to [Main README](../README.md)*
