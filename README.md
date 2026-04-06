# 30 Days of OpenTofu 🧊

A practical, day-by-day curriculum for understanding the end-to-end flow of Infrastructure as Code using OpenTofu, the community-driven evolution of the HCL ecosystem.

---

## Estimated commitment

- Recommended: 1–2 hours/day for guided learning, 3–4 hours on project days.
- Adjust pace: skip sections you already know or expand project days into multiple sessions.

---

## 🛠 Phase 1: Foundations & HCL (Days 1–7)

*Goal: Read, write, and run HCL; understand OpenTofu lifecycle and state.*

- Day 01 — Objective: Understand IaC principles and OpenTofu’s value.
  - Checklist: Read OpenTofu overview; compare license and community notes.
  - Lab: Create a local repo and write your first `main.tf` that creates a dummy resource (provider: local or null).

- Day 02 — Objective: Install and configure OpenTofu and CLIs.
  - Checklist: Install binaries, run `tofu init`, configure Azure/AWS credentials.
  - Lab: Validate provider auth and run `tofu plan` (no resources).

- Day 03 — Objective: HCL syntax — variables, maps, lists, outputs.
  - Checklist: Define variables with type constraints and defaults; create outputs for previous lab.
  - Lab: Use `terraform console`-equivalent (OpenTofu console) to evaluate expressions.

- Day 04 — Objective: OpenTofu lifecycle commands.
  - Checklist: Practice `init`, `plan`, `apply`, `destroy` with the sample project.
  - Lab: Capture and inspect state file; try `taint` and targeted apply.

- Day 05 — Objective: Resource dependency model.
  - Checklist: Demonstrate implicit dependencies via references and explicit `depends_on`.
  - Lab: Build two resources with a dependency and observe plan ordering.

- Day 06 — Objective: Data sources.
  - Checklist: Read cloud provider docs for data sources; add a data lookup to a config.
  - Lab: Query an existing VNet/subnet and use it in a sample deployment.

- Day 07 — Project 1: Deploy a Static Website to Azure Blob Storage.
  - Checklist: Create resource group, storage account, enable static website hosting, upload index.html.
  - Deliverable: `day-07/` branch with `main.tf`, `variables.tf`, `outputs.tf`, and a README.

---

## ☁️ Phase 2: Azure Infrastructure (Days 8–15)

*Goal: Build secure, production-ready Azure infra components.*

- Day 08 — Objective: Remote state with Azure Storage.
  - Checklist: Configure backend, enable state locking.

- Day 09 — Objective: VNet and subnet design.
  - Checklist: Create hub/spoke sample topology and document CIDR choices.

- Day 10 — Objective: NSGs and network rules.
  - Checklist: Implement least-privilege rules and test connectivity.

- Day 11 — Objective: Identity and RBAC.
  - Checklist: Create managed identity, assign roles, and test access from a VM or function.

- Day 12 — Objective: Secrets and Key Vault.
  - Checklist: Store a secret and reference it via provider; enable soft-delete.

- Day 13 — Objective: Provision AKS cluster (baseline).
  - Checklist: Create cluster, node pools, and kubeconfig output.

- Day 14 — Objective: AKS scaling and node management.
  - Checklist: Add autoscaling and validate pod scheduling.

- Day 15 — Project 2: Secure AKS with private networking.
  - Checklist: Private AKS cluster, private endpoint, and restricted API server.
  - Deliverable: `day-15/` with module usage and network diagram.

---

## 🏗 Phase 3: Azure Deep Dive & Security (Days 16–23)

*Goal: Master complex Azure architectures, global networking, and enterprise governance.*

- Day 16 — Objective: Azure SQL and Database Security.
  - Checklist: Provision Azure SQL with Private Endpoints, audit logging, and TDE.
  - Lab: Lock down a database so it's only accessible via a specific VNet/Subnet.

- Day 17 — Objective: App Service and VNet Integration.
  - Checklist: Deploy an App Service with Regional VNet Integration and Private Link.
  - Lab: Connect a PaaS app to a private database without using public IPs.

- Day 18 — Objective: Application Gateway and WAF.
  - Checklist: Configure an L7 Load Balancer with Web Application Firewall (WAF) policies.
  - Lab: Path-based routing and SSL termination for internal services.

- Day 19 — Objective: Azure Front Door.
  - Checklist: Global traffic acceleration and security with Front Door.
  - Lab: Implement a global entry point for multi-region Azure App Services.

- Day 20 — Objective: Observability with Azure Monitor.
  - Checklist: Log Analytics workspaces, Diagnostic Settings, and KQL basics.
  - Lab: Export Terraform logs to Log Analytics and build a resource health dashboard.

- Day 21 — Objective: Azure Policy as Code.
  - Checklist: Implement naming conventions and allowed-region guardrails using Terraform.
  - Lab: Assign a policy that denies non-compliant resources and test it via `tofu apply`.

- Day 22 — Objective: Cost Management and Optimization.
  - Checklist: Create budget alerts and automated tagging strategies.
  - Lab: Use Terraform to enforce mandatory tags for cost-center allocation.

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

## Resources and links

- OpenTofu: https://github.com/opentofu/opentofu
- Terraform docs (concepts and HCL): https://www.terraform.io/docs
- Azure docs: https://learn.microsoft.com/azure
