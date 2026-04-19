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
- Day 23 — Project 3: Secure Multi-tier PaaS Architecture.
  - Checklist: Combine App Service, SQL, Key Vault, and App Gateway into a hardened environment.
  - Deliverable: `day-23/` with a full "Landing Zone" style deployment.

---

## 🚀 Phase 4: Advanced Patterns & Multi-Cloud (Days 24–30)

*Goal: Scale your automation, test patterns, and validate across clouds.*

- Day 24 — Objective: Modules and registry.
  - Checklist: Build a reusable module, add versioning, and refactor Azure labs into modules.
  - Lab: Publish to a module registry (or local mirror).

- Day 25 — Objective: Advanced expressions (`count`, `for_each`, dynamic blocks).
  - Checklist: Refactor duplicate resources into loops and parameterized modules.
  - Lab: Use `for_each` to manage multiple VNets or subnets dynamically.

- Day 26 — Objective: Testing with `tofu test` and policy-as-code.
  - Checklist: Write unit tests for modules and add simple policy checks (e.g., Checkov or TFLint).
  - Lab: Verify module outputs and resource attributes via automated tests.

- Day 27 — Objective: CI/CD with GitHub Actions and OIDC.
  - Checklist: Create an action workflow that runs `tofu fmt`, `tofu init`, `tofu plan` and `tofu apply` using OIDC.
  - Lab: Implement drift detection and automated plan summaries on PRs.

- Day 28 — Objective: AWS Introduction for Azure Engineers.
  - Checklist: Networking (VPC) and Identity (IAM) comparison to Azure VNets/Entra ID.
  - Lab: Provision an S3 bucket with a basic IAM policy and compare to Azure Blob/RBAC.

- Day 29 — Objective: AWS Compute and EKS.
  - Checklist: Launch an EKS cluster basics or an EC2 instance with proper IAM roles.
  - Lab: Compare EKS node pools and networking (VPC CNI) with Azure AKS patterns.

- Day 30 — Final Capstone: Multi-Cloud Traffic Management.
  - Checklist: Combine Azure and AWS projects; implement cross-cloud DNS failover or global routing.
  - Deliverable: `day-30/` with design doc, modules, and multi-cloud orchestration.

---

## 📚 Appendix A: AWS Validation with OpenTofu (Optional)

*Goal: Validate Azure-based infrastructure patterns on AWS using OpenTofu, 
focusing on common services and cloud-agnostic design principles.*

- A1 — Objective: AWS Core Concepts (from Azure perspective).
  - Checklist:
    - Compare VNet ↔ VPC, NSG ↔ Security Groups, Blob Storage ↔ S3, Entra ID ↔ IAM
    - Identify similarities and differences in networking, identity, and storage models
  - Lab:
    - Create a comparison table and simple architecture diagram

- A2 — Objective: AWS Core Infrastructure with OpenTofu.
  - Checklist:
    - Provision VPC, public subnet, and internet gateway
    - Configure security group for basic access (e.g., HTTP/SSH)
    - Create IAM role and attach appropriate permissions
    - Launch EC2 instance with a basic application (e.g., Nginx or container)
    - (Optional) Provision S3 bucket for object storage
  - Lab:
    - Deploy a working EC2-based service using OpenTofu

- A3 — Objective: Multi-Cloud Validation (Optional).
  - Checklist:
    - Deploy equivalent services on Azure and AWS
    - Compare infrastructure design, configuration, and trade-offs
  - Deliverable:
    - `day-a3/` with architecture notes and Terraform configurations

---

## Resources and links

- OpenTofu: https://github.com/opentofu/opentofu
- Terraform docs (concepts and HCL): https://www.terraform.io/docs
- Azure docs: https://learn.microsoft.com/azure
