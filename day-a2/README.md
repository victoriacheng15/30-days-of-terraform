# Day A2: Secure AWS Web Stack

## Introduction

Day A2 upgrades your AWS foundation by deploying a production-ready **Secure 2-Tier Architecture**. Instead of exposing a VM directly to the internet, you will leverage an **Application Load Balancer (ALB)** in a public subnet to route traffic to an EC2 instance residing in a **Private Subnet**.

This day is about answering: **how do I implement enterprise-grade security and secret management in AWS?**

## Key Concepts

- **Private Subnets:** Subnets with no direct route to an Internet Gateway. They are ideal for compute resources and databases.
- **Application Load Balancer (ALB):** A Layer 7 load balancer that provides a single entry point and abstracts the underlying compute.
- **AWS Secrets Manager:** Equivalent to **Azure Key Vault (Secrets)**. It provides a secure way to store and rotate application credentials.
- **Security Group Chaining:** The EC2 instance only allows traffic from the ALB's security group, creating a "Trusted Subnet" pattern.

---

## Mapping Architecture

| Azure Component | AWS Counterpart | Role |
| :--- | :--- | :--- |
| Application Gateway | Application Load Balancer (ALB) | External-facing entry point and traffic routing. |
| Azure Key Vault (Secrets) | AWS Secrets Manager | Secure credential storage. |
| Private Subnet | Private Subnet | Isolation of sensitive compute resources. |
| NSG Rules (Source SG) | SG Chaining | Explicitly allowing traffic from the LB to the App. |

---

## Checklist

- [x] Provision a VPC with Public and Private subnets.
- [x] Create a NAT Gateway for Private Subnet outbound connectivity.
- [x] Create an AWS Secrets Manager secret for application configuration.
- [x] Configure an ALB to listen on port 80 and route to a Target Group.
- [x] Launch an EC2 instance in the Private Subnet with an IAM Instance Profile.
- [x] Implement Security Group chaining (ALB → EC2).
- [x] Grant EC2 IAM role permissions to read Secrets Manager.

---

## Lab: Deploy the Secure Stack

In this lab, you provision a multi-tier network and verify the security boundaries.

### Steps

1. Initialize and apply:

   ```bash
   tofu init
   tofu apply -auto-approve
   ```

2. **Validation:**

   ```bash
   # Get the ALB DNS name
   export ALB_DNS=$(tofu output -raw alb_dns_name)
   
   # Verify web server access via the Load Balancer (allow ~60s for EC2 to start)
   curl http://$ALB_DNS
   
   # Verify EC2 is in private subnet and unreachable directly
   aws ec2 describe-instances --instance-ids $(tofu output -raw ec2_private_ip) --region ca-central-1
   
   # Verify Secret exists
   aws secretsmanager describe-secret --secret-id $(tofu output -raw secret_arn) --region ca-central-1
   
   # Verify target group health
   aws elbv2 describe-target-health --target-group-arn $(aws elbv2 describe-target-groups --names day-a2-web-tg --region ca-central-1 --query 'TargetGroups[0].TargetGroupArn' --output text) --region ca-central-1
   ```

3. **Architecture Comparison:**

   | Component | AWS | Azure |
   | :--- | :--- | :--- |
   | Load Balancer | Application Load Balancer (ALB) | Application Gateway |
   | Public Entry Point | ALB in Public Subnet | App Gateway in public tier |
   | Private Compute | EC2 in Private Subnet | VMs in Private Subnet |
   | Secrets Storage | AWS Secrets Manager | Azure Key Vault |
   | NAT for Outbound | NAT Gateway | NAT Gateway / Azure Firewall |
   | Security Isolation | Security Group chaining | NSG rules (source SG) |
   | Service Identity | IAM Instance Profile | Managed Identity |

4. **Key Learnings:**
   - EC2 is **unreachable directly** from the internet (in private subnet)
   - All traffic **flows through ALB** (similar to Azure Application Gateway pattern)
   - EC2 can **assume an IAM role** to access Secrets Manager (equivalent to Azure Managed Identity)
   - NAT Gateway enables **outbound internet** for EC2 (e.g., system updates)

---
*Back to [Main README](../README.md)*
