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
  - Deliverable: `project-1/` branch with `main.tf`, `variables.tf`, `outputs.tf`, and a README.

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
  - Deliverable: `project-2/` with module usage and network diagram.

---

## 🏗 Phase 3: AWS Infrastructure (Days 16–23)
*Goal: Build highly available workloads in AWS and practice state management.*

- Day 16 — Objective: State backend and IAM best practices.
  - Checklist: Configure S3 backend and DynamoDB for locking; create least-privileged IAM roles.

- Day 17 — Objective: VPC design.
  - Checklist: Create multi-AZ VPC with public/private subnets and NAT.

- Day 18 — Objective: EC2 and ASGs.
  - Checklist: Launch an ASG with a simple web server image.

- Day 19 — Objective: ALB and traffic routing.
  - Checklist: Configure ALB, listeners, and target groups across ASG.

- Day 20 — Objective: RDS Multi-AZ.
  - Checklist: Provision an RDS instance with proper subnet group and backups.

- Day 21 — Objective: EKS cluster basics.
  - Checklist: Create EKS cluster and configure `kubeconfig` outputs.

- Day 22 — Objective: EKS security (IRSA).
  - Checklist: Configure OIDC provider and create IAM role for a pod service account.

- Day 23 — Project 3: EKS + RDS (Load-balanced web app).
  - Checklist: Helm chart or manifests, autoscaling, and a secure RDS backend.
  - Deliverable: `project-3/` with README and Terraform modules.

---

## 🚀 Phase 4: Advanced Patterns & CI/CD (Days 24–30)
*Goal: Reuse, test, automate, and govern infrastructure at scale.*

- Day 24 — Objective: Modules and registry.
  - Checklist: Build a reusable module, add versioning, and publish to a module registry (or local mirror).

- Day 25 — Objective: Advanced expressions (`count`, `for_each`, dynamic blocks).
  - Checklist: Refactor duplicate resources into loops and parameterized modules.

- Day 26 — Objective: Testing with `tofu test` and policy-as-code.
  - Checklist: Write unit tests for modules and add simple policy checks (e.g., CIS or guardrails).

- Day 27 — Objective: CI/CD with GitHub Actions and OIDC.
  - Checklist: Create an action workflow that runs `tofu fmt`, `tofu init`, `tofu plan` and `tofu apply` on protected branches using OIDC.
  - Example: Add `.github/workflows/deploy.yml` scaffold in each project.

- Day 28 — Objective: Multi-cloud orchestration patterns.
  - Checklist: Share state and data safely across providers; avoid hard coupling.

- Day 29 — Objective: Governance, drift detection, and import.
  - Checklist: Run drift detection, import an existing resource, and reconcile state.

- Day 30 — Final Capstone: Multi-Cloud Global Load Balancer.
  - Checklist: Combine Azure and AWS projects into a single repo using modules; implement health checks and cross-cloud DNS failover.
  - Deliverable: `capstone/` with design doc, modules, CI workflow, and cost estimates.

---

## Projects & repo layout recommendations

- Use a mono-repo with a `projects/` folder or one repo per project depending on team size.
- Each project: `main.tf`, `variables.tf`, `outputs.tf`, `modules/`, `README.md`, `.github/workflows/`.
- Include a `Makefile` or scripts for common tasks: `make plan`, `make apply`, `make destroy`.

## CI/CD & testing templates

- Add a GitHub Actions scaffold that runs `tofu fmt`, `tofu validate` (if available), `tofu plan` and posts plan summaries as PR comments.
- Use OIDC for short-lived credentials; avoid storing long-lived secrets in the repo.

## Cost & safety notes

- Always use non-production subscriptions for experiments.
- Add budget alerts and tag resources with owner and environment labels.
- Use small instance types and set proper destroy protections only for production.

## Security and governance

- Principle of least privilege for IAM/RBAC.
- Use secret backends (Key Vault/Secrets Manager) and avoid plaintext credentials in code.
- Add basic policy-as-code checks to CI (deny public S3, require encryption, etc.).

## Troubleshooting tips

- If `tofu plan` fails: check provider credentials, ensure required APIs are enabled, and validate variable types.
- Inspect state files cautiously; use `tofu state` commands to inspect and remove tainted resources safely.
- Keep a simple rollback plan and snapshots for state before major changes.

## Resources and links

- OpenTofu: https://github.com/opentofu/opentofu
- Terraform docs (concepts and HCL): https://www.terraform.io/docs
- Azure docs: https://learn.microsoft.com/azure
- AWS docs: https://docs.aws.amazon.com/

---

If this looks good, run `git add README.md && git commit -m "Refine 30-day OpenTofu plan: prerequisites, objectives, projects, CI/CD, and security notes\n\nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"` to save the changes.
