# 30 Days of OpenTofu 🧊

A practical, day-by-day curriculum for understanding the end-to-end flow of Infrastructure as Code using OpenTofu, the community-driven evolution of the HCL ecosystem.

---

## 🛠 Phase 1: Foundations & HCL (Days 1–7)

*Goal: Read, write, and run HCL; understand OpenTofu lifecycle and state.*

- [Day 01](day-01/README.md) — Objective: Understand IaC principles and OpenTofu’s value.
- [Day 02](day-02/README.md) — Objective: Install and configure OpenTofu and CLIs.
- [Day 03](day-03/README.md) — Objective: HCL syntax — variables, maps, lists, outputs.
- [Day 04](day-04/README.md) — Objective: OpenTofu lifecycle commands.
- [Day 05](day-05/README.md) — Objective: Resource dependency model.
- [Day 06](day-06/README.md) — Objective: Data sources.
- [Day 07](day-07/README.md) — Project 1: Deploy a Static Website to Azure Blob Storage.

---

## ☁️ Phase 2: Azure Infrastructure (Days 8–15)

*Goal: Build secure, production-ready Azure infra components.*

- [Day 08](day-08/README.md) — Objective: Remote state with Azure Storage.
- [Day 09](day-09/README.md) — Objective: VNet and subnet design.
- [Day 10](day-10/README.md) — Objective: NSGs and network rules.
- [Day 11](day-11/README.md) — Objective: Identity and RBAC.
- [Day 12](day-12/README.md) — Objective: Secrets and Key Vault.
- [Day 13](day-13/README.md) — Objective: Provision AKS cluster (baseline).
- [Day 14](day-14/README.md) — Objective: AKS scaling and node management.
- [Day 15](day-15/README.md) — Project 2: Secure AKS with private networking.

---

## 🏗 Phase 3: Azure Deep Dive & Security (Days 16–23)

*Goal: Master complex Azure architectures, global networking, and enterprise governance.*

- [Day 16](day-16/README.md) — Objective: Azure SQL and Database Security.
- [Day 17](day-17/README.md) — Objective: App Service and VNet Integration.
- [Day 18](day-18/README.md) — Objective: Application Gateway and WAF.
- [Day 19](day-19/README.md) — Objective: Azure Front Door.
- [Day 20](day-20/README.md) — Objective: Observability with Azure Monitor.
- [Day 21](day-21/README.md) — Objective: Azure Policy as Code.
- [Day 22](day-22/README.md) — Objective: Cost Management and Optimization.
- [Day 23](day-23/README.md) — Project 3: Secure Multi-tier PaaS Architecture.

---

## 🚀 Phase 4: Advanced Patterns & Multi-Cloud (Days 24–30)

*Goal: Scale your automation, test patterns, and validate across clouds.*

- [Day 24](day-24/README.md) — Objective: Modules and registry.
- [Day 25](day-25/README.md) — Objective: Advanced expressions (`count`, `for_each`, dynamic blocks).
- [Day 26](day-26/README.md) — Objective: Testing with `tofu test` and policy-as-code.
- [Day 27](day-27/README.md) — Objective: CI/CD with GitHub Actions and OIDC.
- [Day 28](day-28/README.md) — Objective: AWS Introduction for Azure Engineers.
- [Day 29](day-29/README.md) — Objective: AWS Compute and IAM Roles.
- [Day 30](day-30/README.md) — Final Capstone: Multi-Cloud Traffic Management.

---

## 📚 Appendix A: AWS Infrastructure (Optional)

*Goal: Build practical AWS infrastructure patterns, learning cloud-agnostic design principles and services from an Azure engineer's perspective.*

- [Day A1](day-a1/README.md) — Objective: AWS Identity (IAM) for Azure Engineers.
- [Day A2](day-a2/README.md) — Objective: Secure 2-Tier AWS Architecture with ALB & Secrets.
- [Day A3](day-a3/README.md) — Objective: AWS Data Persistence, Secrets & Monitoring.
- [Day A4](day-a4/README.md) — Objective: AWS Containerization & Advanced Patterns (Optional).

---

## 🔍 Appendix B: How OpenTofu Works Under the Hood (Optional)

*Goal: Understand how OpenTofu manages infrastructure internally through state, providers, dependency graphs, reconciliation, idempotency, drift detection, and resource lifecycle decisions.*

- [Day B1](day-b1/README.md) — Objective: State, providers, and how OpenTofu maps configuration to real infrastructure.
- [Day B2](day-b2/README.md) — Objective: Dependency graph, execution ordering, and resource lifecycle decisions.
- [Day B3](day-b3/README.md) — Objective: Declarative reconciliation, idempotency, and why repeated applies should become no-ops.
- [Day B4](day-b4/README.md) — Objective: Drift detection, refresh behavior, and deciding whether to correct or accept changes.

---

## Resources and links

- OpenTofu: <https://github.com/opentofu/opentofu>
- Terraform docs (concepts and HCL): <https://www.terraform.io/docs>
- Azure docs: <https://learn.microsoft.com/azure>
