# Day 20: Observability with Azure Monitor

## Introduction

Day 20 focuses on observability. You create a Log Analytics workspace, route platform diagnostics into it, and use KQL to inspect activity and health-related events.

This day is about answering: **what happened, where, and when** across your Azure resources.

## Key Concepts

- **Log Analytics Workspace:** Central store for logs and query results.
- **Diagnostic Settings:** Routes platform logs/metrics from Azure resources into Log Analytics.
- **KQL (Kusto Query Language):** Query language used to analyze log data.
- **Saved Searches:** Reusable KQL queries you can run or pin in Azure Monitor workbooks/dashboards.

---

## Checklist

- [x] Create a Log Analytics workspace.
- [x] Configure diagnostic settings at subscription scope.
- [x] Route subscription activity and resource health logs to Log Analytics.
- [x] Add baseline saved KQL queries for activity and health events.

---

## Lab: Centralized Logs + Health View

In this lab, you provision observability plumbing and query the resulting telemetry.

### Steps

1. Initialize the directory with `tofu init`.
2. Review `main.tf`:
   - `azurerm_log_analytics_workspace` for centralized logging.
   - `azurerm_monitor_diagnostic_setting` to export subscription platform data.
   - `azurerm_log_analytics_saved_search` for reusable KQL queries.
3. Run `tofu apply`.
4. In Azure Portal:
   - Open **Log Analytics workspaces** → your workspace.
   - Go to **Logs** and run saved searches in category `day-20-observability`.
5. Validate with sample KQL:

   ```kql
   AzureActivity
   | where TimeGenerated > ago(24h)
   | order by TimeGenerated desc
   ```

6. Build a simple resource health dashboard:
   - Open **Azure Monitor Workbook**.
   - Add query visuals using the saved search queries.
   - Pin the workbook to an Azure dashboard.

---
*Back to [Main README](../README.md)*
