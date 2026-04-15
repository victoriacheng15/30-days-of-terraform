# Day 16: Azure SQL and Database Security

## Introduction

In the first two phases, we built foundational infrastructure and networking. Now, we shift our focus to **Data Security**.

**Azure SQL Database** is a fully managed Platform-as-a-Service (PaaS) database engine. While easy to deploy, its default configuration often includes a public endpoint. For enterprise security, we must ensure our data is never exposed to the public internet.

## Key Concepts

- **Private Endpoint:** Injects the SQL logical server into your Virtual Network (VNet) via a **Private Link**. The database gets a private IP address, and public access is disabled.
- **Audit Logging:** Tracks database events and writes them to an audit log in an Azure Storage account, Log Analytics workspace, or Event Hub.
- **TDE (Transparent Data Encryption):** Encrypts Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics data files (at rest) by default.
- **VNet Service Endpoints vs. Private Link:** While Service Endpoints "inform" the PaaS service about your VNet, **Private Link** is the modern standard that provides a truly private IP within your subnet.

---

## Checklist

- [x] Create a `Virtual Network` and a dedicated `Subnet` for the Private Endpoint.
- [x] Provision an `Azure SQL Server` and `Azure SQL Database`.
- [x] Disable `public_network_access_enabled` on the SQL Server.
- [x] Configure a `Private Endpoint` and `Private DNS Zone` (`privatelink.database.windows.net`) for the SQL Server.
- [x] Enable `Extended Auditing Policy` to send logs to a `Storage Account`.

---

## Lab: Locking Down the Database

In this lab, you will deploy a SQL Database that is only reachable from within your private network.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf`:
   - Notice the `azurerm_mssql_server` resource with `public_network_access_enabled = false`.
   - Observe the `azurerm_private_endpoint` connecting the SQL Server to your subnet.
   - See how the `azurerm_mssql_server_extended_auditing_policy` is configured.
3. Run `tofu plan` to verify the resources.
4. Run `tofu apply` to provision the environment.
5. **Validation:**
   - From your local machine, try to connect to the SQL Server FQDN (e.g., via `sqlcmd` or Azure Data Studio).
   - *It should fail* because public access is blocked.
   - In a production scenario, you would use a **Jumpbox VM** or **VPN/ExpressRoute** to access this private IP.

---
*Back to [Main README](../README.md)*
