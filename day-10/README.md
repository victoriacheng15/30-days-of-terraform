# Day 10: Network Security Groups (NSGs) and Rules

## Introduction

**Network Security Groups (NSGs)** act as a virtual firewall for your subnets and individual network interfaces. They contain a list of security rules that allow or deny inbound or outbound network traffic based on:

- Source and Destination IP address
- Port
- Protocol

## Rule Priority

Rules are processed in priority order (lower numbers first). Once a match is found, no further rules are processed. Each NSG includes default rules that cannot be deleted but can be overridden by rules with higher priority (lower numbers).

## Least Privilege Principle

Always aim for **Least Privilege**. This means only allowing the specific traffic necessary for the application to function. For example:

- **Frontend:** Allow inbound HTTP (80) and HTTPS (443) from the internet.
- **Backend:** Only allow traffic from the Frontend subnet.
- **Database:** Only allow SQL traffic from the Backend subnet.

---

## Checklist

- [x] Create an NSG for each tier (Frontend, Backend, Database).
- [x] Define specific inbound rules for each NSG.
- [x] Associate NSGs with their respective subnets.
- [x] Use `azurerm_network_security_rule` resources or `security_rule` blocks.

---

## Lab: Securing the Network

In this lab, you will apply security rules to the network architecture created in Day 09.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf` to see how NSGs are associated with subnets.
3. Run `tofu apply` to deploy the security configuration.
4. Verify the rules in the Azure Portal or via CLI:

   ```bash
   az network nsg rule list --resource-group rg-day-10-security --nsg-name nsg-frontend
   ```

---
*Back to [Main README](../README.md)*
