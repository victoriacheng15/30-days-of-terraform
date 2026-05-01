# Day A3: AWS Data, Secrets & Monitoring

## Introduction

Day A3 demonstrates how to build a production-ready **data persistence layer** in AWS. You will provision RDS (managed PostgreSQL), S3 object storage with versioning, and CloudWatch monitoring—all with secure credential management via AWS Secrets Manager.

This day is about answering: **how do I deploy secure, observable databases and storage in a cloud-native AWS environment?**

## Key Concepts

- **RDS (Relational Database Service):** Equivalent to **Azure SQL**. It handles patching, backups, and scaling for relational databases.
- **DB Subnet Groups:** A collection of subnets (typically private) that you designate for your RDS instances in a VPC. RDS requires at least two subnets in different AZs for High Availability.
- **S3 Versioning:** A way to keep multiple variants of an object in the same bucket. Ideal for recovery and audit.
- **CloudWatch Alarms:** Equivalent to **Azure Monitor Alerts**. They watch a single metric over a specified period and perform one or more actions based on the value of the metric.
- **Secrets Manager:** Securely store and rotate database credentials. Enables dynamic secret retrieval without hardcoding passwords.

---

## Mapping Data & Monitoring

| Azure Component | AWS Counterpart | Role |
| :--- | :--- | :--- |
| Azure SQL Database | AWS RDS | Managed relational database service. |
| Azure Monitor Alerts | CloudWatch Alarms | Monitoring and alerting based on metrics. |
| Blob Versioning | S3 Versioning | Protecting data from accidental deletes. |
| SQL Firewall Rules | DB Security Groups | Controlling network access to the database. |
| Azure Key Vault | AWS Secrets Manager | Secure credential storage and rotation. |

---

## Checklist

- [x] Provision an RDS PostgreSQL instance in a dedicated subnet group.
- [x] Store DB credentials securely in AWS Secrets Manager.
- [x] Enable Versioning on an S3 Bucket.
- [x] Create a CloudWatch Metric Alarm to monitor RDS CPU utilization.
- [x] Export the RDS endpoint, S3 bucket name, and secret ARN for verification.

---

## Lab: Deploy Data, Secrets & Monitoring Stack

In this lab, you provision the persistence layer, secure credential management, and corresponding monitoring.

### Steps

1. Initialize and apply:

   ```bash
   tofu init
   tofu apply -auto-approve
   ```

2. **Validation:**

   ```bash
   # Verify RDS Status
   aws rds describe-db-instances --db-instance-identifier $(tofu output -raw rds_instance_id) --region ca-central-1
   
   # Verify S3 Versioning
   aws s3api get-bucket-versioning --bucket $(tofu output -raw s3_bucket_name) --region ca-central-1
   
   # Check CloudWatch Alarm
   aws cloudwatch describe-alarms --alarm-names day-a3-rds-cpu-high --region ca-central-1
   
   # Retrieve DB credentials from Secrets Manager
   aws secretsmanager get-secret-value --secret-id $(tofu output -raw db_secret_arn) --region ca-central-1
   ```

3. **Architecture Comparison:**

   | Component | AWS | Azure |
   | :--- | :--- | :--- |
   | Managed Database | AWS RDS | Azure SQL Database |
   | Monitoring/Alerts | CloudWatch Alarms | Azure Monitor Alerts |
   | Object Storage | Amazon S3 | Azure Blob Storage |
   | Secret Storage | AWS Secrets Manager | Azure Key Vault |
   | Subnet Isolation | DB Subnet Group | Subnet Delegation |

4. **Key Learnings:**
   - Passwords are **never hardcoded**—use Secrets Manager
   - RDS requires **multi-AZ subnet group** for high availability
   - S3 versioning protects against accidental data loss
   - CloudWatch alarms enable **proactive monitoring**

---
*Back to [Main README](../README.md)*
