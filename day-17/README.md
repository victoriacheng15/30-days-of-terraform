# Day 17: App Service and VNet Integration

## Introduction

In Day 16, we locked down our SQL Database with a Private Endpoint. Now, how does our application—the **Azure App Service**—actually talk to that database?

By default, an App Service is a public multi-tenant service. To let it "reach into" our private network, we use **Regional VNet Integration**.

## Key Concepts

- **Regional VNet Integration (Outbound):** Allows the App Service to send outbound traffic into your VNet. This is what lets the app reach SQL over private networking.
- **Private Endpoint for SQL (Inbound to SQL):** The SQL Server is exposed through a private IP inside your VNet, with public SQL access disabled.
- **Private DNS Zone:** `privatelink.database.windows.net` ensures the SQL FQDN resolves to the private endpoint IP from inside the VNet-integrated app path.
- **Subnet Delegation:** The subnet used for VNet Integration must be **delegated** to the `Microsoft.Web/serverFarms` service. This is a special Azure requirement.
- **Service Tags vs. VNet Integration:** Service tags allow traffic *from* Azure services, but **VNet Integration** makes the app *part* of your network.

---

## Checklist

- [x] Create a `Virtual Network` with a dedicated subnet for **VNet Integration**.
- [x] Add `delegation` to the integration subnet for `Microsoft.Web/serverFarms`.
- [x] Provision an `App Service Plan` (must be `Basic` or higher for VNet Integration).
- [x] Deploy a `Linux Web App` with `virtual_network_subnet_id` configured.
- [x] Connect the App Service to the private `SQL Database` from Day 16.

---

## Lab: Connecting PaaS to Private Data

In this lab, you will deploy a Web App that communicates with a private SQL server through the Azure backbone.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf`:
   - Notice the `azurerm_subnet` with the `delegation` block.
   - See how the SQL Server has `public_network_access_enabled = false`.
   - See the `connection_string` configured to use the SQL FQDN.
   - Notice the Private DNS Zone + VNet link + Private Endpoint DNS zone group wiring.
3. Run `tofu apply`.
4. **Validation:**
   - In Azure Portal, open **Web App > Networking > VNet Integration** and confirm status is **Integrated/Connected** to `snet-app-integration`.
   - Open **SQL Server > Networking > Private access** and confirm `pe-sql-day17` is **Approved**.
   - Open **Private DNS zones > privatelink.database.windows.net** and confirm:
     - VNet link exists to `vnet-day17`.
     - An A-record exists for the SQL server and points to a private IP.
   - In Web App **SSH/Console**, run:
     - `nslookup <your-sql-server>.database.windows.net`
     - Confirm name resolution goes through `privatelink.database.windows.net` to a private `10.x.x.x` address.
   - Verify app logs show a successful SQL connection/query using the configured connection string.
   - *Use DNS resolution + real DB connection as proof. `ping` is not a reliable validation method for Azure SQL.*

---
*Back to [Main README](../README.md)*
