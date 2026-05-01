# Day A4: AWS Serverless Glue (Lambda & API Gateway)

## Introduction

copilot --resume="Fix OpenTofu Type Quotes"

Day A4 introduces the "modern" AWS architectural pattern: **Serverless**. In Azure, you might use **App Service** or **Azure Functions** for lightweight tasks. In AWS, **Lambda** is the ubiquitous service used for everything from API backends to infrastructure automation "glue."

This day is about answering: **how do I deploy event-driven, zero-server logic using OpenTofu?**

## Key Concepts

- **AWS Lambda:** A compute service that lets you run code without provisioning or managing servers. You only pay for the compute time you consume.
- **API Gateway (v2/HTTP):** A managed service that makes it easy for developers to create, publish, and secure APIs at any scale. We use the "HTTP API" version for its simplicity and speed.
- **Lambda Execution Role:** A specific IAM role that the Lambda function assumes to gain permissions to other AWS services (like CloudWatch Logs).
- **Triggers & Permissions:** The bridge that allows API Gateway to "invoke" the Lambda function.

---

## Mapping Serverless Primitives

| Azure Component | AWS Counterpart | Role |
| :--- | :--- | :--- |
| Azure Functions | AWS Lambda | Event-driven serverless compute. |
| API Management (APIM) | API Gateway | Front-door for APIs; handles routing and security. |
| Function App Service Plan | (None - Truly Serverless) | AWS handles all underlying scaling. |
| Application Insights | CloudWatch Logs | Distributed logging and monitoring. |

---

## Checklist

- [x] Create an IAM Execution Role for the Lambda function.
- [x] Write a simple Python/NodeJS "Hello World" function.
- [x] Provision a Lambda function using the `archive_file` data source.
- [x] Deploy an API Gateway (HTTP API) with a route to the Lambda.
- [x] Grant API Gateway the permission to invoke the Lambda.
- [x] Verify the endpoint via `curl`.

---

## Lab: Deploy a Serverless API

In this lab, you deploy a functional HTTP endpoint backed by a serverless function.

### Steps

1. Review the configuration files:
   - `main.tf`: Defines the IAM role, Lambda function, and API Gateway.
   - `hello.py`: The Python code that will run in the Lambda.

2. Initialize and apply:

   ```bash
   tofu init
   tofu apply -auto-approve
   ```

3. **Validation:**

   ```bash
   # Get the API endpoint URL
   export API_URL=$(tofu output -raw api_endpoint)
   
   # Invoke the function
   curl $API_URL
   
   # Check logs in CloudWatch
   aws logs tail /aws/lambda/day-a4-hello-function --region ca-central-1
   ```

4. Compare architecture:
   - Lambda ↔ Azure Functions.
   - API Gateway ↔ Azure API Management.
   - IAM Execution Role ↔ Managed Identity (Function Level).

---
*Back to [Main README](../README.md)*
