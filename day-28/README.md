# Day 28: AWS Introduction for Azure Engineers

## Introduction

Day 28 focuses on mapping Azure concepts to AWS using OpenTofu. You provision an S3 bucket and IAM policy, then compare these patterns with Azure Blob Storage and RBAC.

This day is about answering: **how do Azure storage/identity patterns translate to AWS?**

## Key Concepts

- **VNet vs VPC:** Azure Virtual Network maps conceptually to AWS VPC.
- **Blob vs S3:** Azure Blob Storage maps to AWS S3 buckets and objects.
- **RBAC vs IAM:** Azure role assignments map to AWS IAM policies and attachments.
- **Public access hardening:** S3 Public Access Block is similar to enforcing non-public storage posture in Azure.

---

## Checklist

- [x] Configure AWS provider and region inputs.
- [x] Create an S3 bucket with versioning enabled.
- [x] Enforce S3 public access block settings.
- [x] Create an IAM policy for bucket/object read-write access.
- [x] Expose bucket and policy outputs for verification.

---

## Lab: Provision S3 + IAM Policy with OpenTofu

In this lab, you deploy a secure S3 bucket baseline and an IAM policy for application-style access.

### Steps

1. Confirm AWS profile/session:

   ```bash
   aws configure list-profiles
   export AWS_PROFILE=<your-sso-profile>
   aws sts get-caller-identity --region <your-region>
   ```

2. Initialize the directory with `tofu init`.
3. Review `main.tf`:
   - `aws_s3_bucket.main` creates the bucket.
   - `aws_s3_bucket_public_access_block.main` enforces non-public access.
   - `aws_s3_bucket_versioning.main` enables object versioning.
   - `aws_iam_policy.s3_rw` creates a policy from `aws_iam_policy_document`.
4. Run `tofu apply`.
5. **Validation:**

   ```bash
   tofu output
   aws s3api get-bucket-versioning --bucket <your-s3-bucket-name> --region ca-central-1
   aws s3api get-public-access-block --bucket <your-s3-bucket-name> --region ca-central-1
   aws iam get-policy --policy-arn <your-iam-policy-arn> --region ca-central-1
   ```

6. Compare architecture:
   - S3 bucket ↔ Azure Storage Account + Blob container
   - IAM policy ↔ Azure custom role / role assignment

---
*Back to [Main README](../README.md)*
