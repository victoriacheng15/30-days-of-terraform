# Day 18: Application Gateway and WAF

## Introduction

In Day 17, we connected App Service to SQL over private networking. Now we protect and route inbound traffic at Layer 7 using **Azure Application Gateway** with a **Web Application Firewall (WAF)** policy.

This pattern gives a single entry point for web traffic, applies WAF protections, and supports path-based routing to multiple backends.

## Key Concepts

- **Application Gateway (L7 Load Balancer):** Routes HTTP/S traffic using host and path rules.
- **WAF Policy:** Inspects and blocks common web attacks (OWASP managed rules).
- **Path-based Routing:** Sends traffic like `/api/*` to a different backend than `/`.
- **SSL Termination:** Decrypts HTTPS at the gateway and forwards traffic to backends.
- **Dedicated Subnet Requirement:** Application Gateway must run in its own subnet.

---

## Checklist

- [x] Create a dedicated subnet for `azurerm_application_gateway`.
- [x] Provision a WAF_v2 Application Gateway with a public frontend IP.
- [x] Attach a `azurerm_web_application_firewall_policy` in prevention mode.
- [x] Configure path-based routing (`/api/*` to API backend, default to web backend).
- [x] Support optional HTTPS listener and SSL termination via PFX inputs.

---

## Lab: Path Routing + WAF Controls

In this lab, you will build an internet-facing entry point that protects and routes traffic to separate backend services.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf`:
   - Confirm the dedicated Application Gateway subnet.
   - Observe WAF policy attachment (`firewall_policy_id`).
   - Check the `url_path_map` and `/api/*` routing rule.
3. (Optional) Enable HTTPS by setting:
   - `enable_https = true`
   - `ssl_certificate_data` (base64-encoded PFX)
   - `ssl_certificate_password`
4. Run `tofu apply`.
5. **Validation:**
   - In Azure Portal, confirm Application Gateway SKU is `WAF_v2`.
   - Confirm WAF policy mode is `Prevention`.
   - Send request to `/` and verify default backend is used.
   - Send request to `/api/health` and verify API backend is used.
   - If HTTPS is enabled, verify TLS terminates at Application Gateway listener.

---
*Back to [Main README](../README.md)*
