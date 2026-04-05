# Day 14: AKS scaling and node management

## Introduction

In Day 13, we deployed a static cluster with a single fixed node. In the real world, application traffic varies. **Autoscaling** allows your cluster to respond to changes in demand automatically.

There are two main types of scaling in AKS:
1. **Cluster Autoscaler:** Monitors for pods that can't be scheduled on existing nodes due to resource constraints and automatically adds/removes nodes in your VMSS.
2. **Horizontal Pod Autoscaler (HPA):** Scales the number of pod replicas based on CPU/memory usage.

Today, we focus on the **Cluster Autoscaler** by enabling it directly on the node pool.

## The Cluster Autoscaler Loop

1. **Observe:** The Cluster Autoscaler checks the API server every ~10 seconds for "Unscheduled Pods."
2. **Decide:** If a pod is unschedulable because the nodes are full, it calculates how many more nodes are needed.
3. **Act:** It tells the Azure VMSS to increase its capacity.
4. **Scale Down:** If a node is underutilized and all its pods can be moved to other nodes, it will eventually remove that node to save costs.

---

## Checklist

- [x] Enable `auto_scaling_enabled` on the default node pool.
- [x] Define `min_count` and `max_count` (e.g., 1 to 3).
- [x] Validate pod scheduling by deploying a "heavy" workload.

---

## Lab: Scaling the Cluster

In this lab, you will see the VMSS in action as it responds to "resource pressure."

### Steps

1. Initialize your directory with `tofu init`.
2. Run `tofu apply` to update your cluster (or deploy a new one if you destroyed Day 13).
3. Connect to your cluster:
   ```bash
   tofu output -raw kube_config > azurek8s
   export KUBECONFIG=$(pwd)/azurek8s
   ```
4. Check the current node count:
   ```bash
   kubectl get nodes
   ```
5. Deploy the "Stress" test:
   ```bash
   kubectl apply -f stress-test.yaml
   ```
6. Observe the "Pending" pods and the nodes being added:
   ```bash
   # In one terminal, watch the pods
   kubectl get pods -w
   
   # In another terminal, watch the nodes scale up
   kubectl get nodes -w
   ```
7. Once you see the new node join and the pods transition from `Pending` to `Running`, clean up the test:
   ```bash
   kubectl delete -f stress-test.yaml
   ```

---
*Back to [Main README](../README.md)*
