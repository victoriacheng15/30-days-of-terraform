# Day A1: AWS Identity (IAM) for Azure Engineers

## Introduction

Appendix A1 establishes the mental model for mapping Azure infrastructure to AWS. For an engineer transitioning from Azure, the primary shift is moving from the Subscription/Resource Group hierarchy to the Account/VPC model.

This day is about answering: **how do I translate my Azure RBAC and Managed Identity knowledge into AWS IAM?**

## Key Concepts

- **IAM User vs Entra User:** AWS IAM users are local to the account unless part of an Organization.
- **IAM Policy vs Azure Role:** AWS uses JSON-based policies to define allowed actions. These are more granular and can be attached to Users, Groups, or Roles.
- **IAM Role vs Managed Identity:** AWS Roles are entities that can be "assumed" by users or services (like EC2). This is functionally equivalent to Azure's Managed Identity.
- **Access Keys vs Service Principals:** AWS Access Keys are long-lived credentials for users. In Azure, you typically use Client Secrets with Service Principals.

---

## Mapping Identity Primitives

| Azure Concept | AWS Counterpart | Function |
| :--- | :--- | :--- |
| Entra ID User | IAM User | Human or application identity. |
| Managed Identity | IAM Role | Identity for services (no static credentials). |
| Azure RBAC Role | IAM Policy | JSON document defining permissions. |
| Role Assignment | Policy Attachment | Binding a policy to an identity. |

---

## Checklist

- [x] Compare Entra ID ↔ AWS IAM.
- [x] Configure local AWS credentials with `aws configure`.
- [x] Initialize the environment and provision a lab IAM user with restricted permissions.

---

## Lab: Provisioning AWS Identity

In this lab, you verify your root identity, create a new IAM user, and attach a custom read-only policy.

### Steps

1. Configure your AWS environment:

   ```bash
   aws configure
   ```

2. Initialize and apply:

   ```bash
   tofu init
   tofu apply -auto-approve
   ```

3. View the generated credentials:

   ```bash
   # Reveal the sensitive secret key
   tofu output lab_secret_access_key
   ```

4. **Validation:**

   ```bash
   # Verify the user exists in AWS
   aws iam get-user --user-name day-a1-lab-user
   
   # List the policies attached to the user
   aws iam list-attached-user-policies --user-name day-a1-lab-user
   ```

5. Compare architecture:
   - Creating an `aws_iam_user` ↔ Creating a Service Principal/User in Entra.
   - Attaching `aws_iam_policy` ↔ Azure Role Assignment (`azurerm_role_assignment`).

---
*Back to [Main README](../README.md)*
