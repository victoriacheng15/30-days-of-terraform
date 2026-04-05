# Day 13: Provision AKS cluster (baseline)

## Introduction

**Azure Kubernetes Service (AKS)** is a managed container orchestration service based on the open-source Kubernetes system. It simplifies deploying, managing, and scaling containerized applications using Kubernetes on Azure.

In this lab, we will provision a baseline AKS cluster. This is the foundation for Day 14 (Scaling) and Day 15 (Secure Networking).

## Key Components

- **Control Plane:** Managed by Azure at no cost (unless using Uptime SLA). It includes the API server, scheduler, and controller manager.
- **Node Pools:** A group of nodes with the same configuration (VM size, OS, etc.). A "System" node pool is required to host critical system pods.
- **Identity:** AKS uses a Managed Identity (or Service Principal) to interact with other Azure resources like Load Balancers and Managed Disks.

---

## Checklist

- [x] Create an `Azure Resource Group`.
- [x] Provision an `AKS Cluster` with a `System` node pool.
- [x] Configure `SystemAssigned` Managed Identity for the cluster.
- [x] Output the `kubeconfig` to allow `kubectl` connectivity.

---

## Lab: Launching the Fleet

In this lab, you will deploy your first managed Kubernetes cluster.

### Steps

1. Initialize your directory with `tofu init`.
2. Review `main.tf` to understand the `azurerm_kubernetes_cluster` resource.
3. Run `tofu apply` to deploy the cluster. **Note:** This can take 5–10 minutes.
4. Once complete, extract the `kubeconfig`:

   ```bash
   tofu output -raw kube_config > azurek8s
   export KUBECONFIG=$(pwd)/azurek8s
   ```

5. Verify connectivity:

   ```bash
   kubectl get nodes
   ```

---
*Back to [Main README](../README.md)*
