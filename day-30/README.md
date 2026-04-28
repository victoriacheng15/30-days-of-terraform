# Day 30: Multi-Cloud Traffic Management Capstone

## Introduction

Day 30 is the final capstone for the 30 Days of OpenTofu curriculum. You combine Azure and AWS patterns by building a global failover entry point with Azure Traffic Manager and optional Route53 DNS integration.

This day is about answering: **how do we route traffic across clouds with infrastructure-as-code?**

## Key Concepts

- **Global entry point:** One DNS target routes users to healthy endpoints.
- **Priority failover:** Azure endpoint acts as primary and AWS endpoint as secondary.
- **Cross-cloud orchestration:** One OpenTofu stack manages Azure + AWS resources together.
- **Operational readiness:** Health monitoring and DNS outputs support validation and incident workflows.

---

## Checklist

- [x] Configure both Azure and AWS providers in one stack.
- [x] Deploy Azure App Service as primary endpoint.
- [x] Deploy AWS EC2 web server as secondary endpoint.
- [x] Create an Azure Traffic Manager profile with health monitoring.
- [x] Register provisioned Azure/AWS endpoints in Traffic Manager.
- [x] Add optional Route53 CNAME integration to point custom DNS to Traffic Manager.
- [x] Expose outputs for traffic manager and DNS verification.

---

## Lab: Deploy Multi-Cloud DNS Failover

In this lab, you deploy both cloud endpoints and wire them into one global traffic management layer.

### Steps

1. Confirm Azure and AWS sessions:

   ```bash
   az account show
   aws sts get-caller-identity --region ca-central-1
   ```

2. Initialize the directory with `tofu init`.
3. Deploy all resources with `tofu apply`.

4. (Optional) Create Route53 DNS record:

   ```bash
   tofu apply \
     -var='create_route53_record=true' \
     -var='route53_zone_id=Z1234567890ABC' \
     -var='route53_record_name=global-app.example.com'
   ```

5. **Validation:**

   ```bash
   tofu output
   az webapp list --resource-group rg-day30-multicloud --query "[].defaultHostName"
   aws ec2 describe-instances --instance-ids <aws-ec2-instance-id> --region ca-central-1
   az network traffic-manager profile show --resource-group rg-day30-multicloud --name tm-day30-global
   nslookup <traffic-manager-fqdn>
   curl http://<aws-ec2-public-ip>
   ```

6. Compare architecture:
   - Azure Traffic Manager ↔ Route53 failover routing policies
   - Azure App Service (primary) + AWS EC2 web server (secondary) ↔ cross-cloud HA strategy

---
*Back to [Main README](../README.md)*
