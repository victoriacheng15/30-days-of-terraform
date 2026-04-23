# Day 29: AWS Compute and IAM Roles

## Introduction

Day 29 focuses on AWS compute patterns with OpenTofu. You provision an EC2 instance, attach an IAM role (instance profile), and secure access with a security group.

This day is about answering: **how do EC2 + IAM role patterns compare to Azure VM + managed identity?**

## Key Concepts

- **EC2 vs Azure VM:** Core compute service concepts are similar, but lifecycle and defaults differ.
- **IAM Role vs Managed Identity:** EC2 instance profiles provide role-based access without static keys.
- **Security Group vs NSG:** Both control inbound/outbound traffic at network boundaries.
- **Bootstrap with user data:** Similar to cloud-init/custom script extension patterns.

---

## Checklist

- [x] Configure AWS provider and region inputs.
- [x] Discover default VPC and subnet for quick lab deployment.
- [x] Create a security group for SSH/HTTP traffic.
- [x] Create an IAM role + instance profile for EC2.
- [x] Launch EC2 and expose validation outputs.

---

## Lab: Provision EC2 + IAM Role with OpenTofu

In this lab, you deploy a basic EC2 web server and attach an IAM role using an instance profile.

### Steps

1. Confirm AWS profile/session:

   ```bash
   aws configure list-profiles
   export AWS_PROFILE=<your-sso-profile>
   aws sts get-caller-identity --region <your-region>
   ```

2. Initialize the directory with `tofu init`.
3. Review `main.tf`:
   - `aws_security_group.web` allows SSH and HTTP.
   - `aws_iam_role.ec2_instance_role` and `aws_iam_instance_profile.ec2_profile` attach IAM permissions to EC2.
   - `aws_instance.web` launches Amazon Linux 2023 with NGINX bootstrap via `user_data`.
4. Run `tofu apply`.
5. **Validation:**

   ```bash
   tofu output
   aws ec2 describe-instances --instance-ids <ec2-instance-id> --region ca-central-1
   aws iam get-role --role-name day29-ec2-role --region ca-central-1
   curl http://<ec2-public-ip>
   ```

6. Compare architecture:
   - EC2 instance ↔ Azure Virtual Machine
   - IAM role + instance profile ↔ Managed identity + role assignment
   - Security group ↔ NSG rules

---
*Back to [Main README](../README.md)*
