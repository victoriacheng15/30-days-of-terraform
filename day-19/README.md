# Day 19: Azure Front Door

## Introduction

Day 18 handled regional ingress with Application Gateway + WAF. Day 19 moves to **global ingress** using **Azure Front Door** for worldwide entry, acceleration, and failover across regional backends.

Azure Front Door is designed for edge routing. It directs users to the healthiest backend and applies Layer 7 security policies close to the client.

## Key Concepts

- **Global Anycast Edge:** Users connect to the nearest Microsoft edge POP.
- **Origin Group + Health Probes:** Front Door monitors backends and routes to healthy origins.
- **Priority-based Failover:** Primary origin is preferred; secondary origin is used during outages.
- **Front Door WAF Policy:** Applies edge security policy to incoming HTTP(S) traffic.
- **HTTPS Redirect + TLS Offload:** Enforces HTTPS on the public endpoint.

---

## Checklist

- [x] Create a Front Door Standard profile and endpoint.
- [x] Configure one origin group with primary and secondary backend origins.
- [x] Enable health probing and load-balancing settings.
- [x] Add a route for `/*` and force HTTPS forwarding.
- [x] Attach a WAF policy in `Prevention` mode.

---

## Lab: Global Entry Point with Failover

In this lab, you create a single global endpoint that can front two regional app services.

### Steps

1. Initialize the directory with `tofu init`.
2. Update backend variables if needed:
   - `primary_origin_host`
   - `secondary_origin_host`
3. Review `main.tf`:
   - `azurerm_cdn_frontdoor_origin_group` for health probes.
   - `priority` values on primary/secondary origins.
   - `azurerm_cdn_frontdoor_route` for HTTPS-only forwarding.
   - WAF policy + security policy association.
4. Run `tofu apply`.
5. **Validation:**
   - In Azure Portal, open Front Door endpoint and confirm it is `Enabled`.
   - Confirm route `route-default` is active with pattern `/*`.
   - Confirm WAF policy mode is `Prevention`.
   - Open the output `frontdoor_url` and verify traffic reaches the backend.
   - Simulate primary backend failure and verify Front Door shifts traffic to secondary origin.

---
*Back to [Main README](../README.md)*
