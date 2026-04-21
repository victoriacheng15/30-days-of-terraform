variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "ca-central-1"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "bucket_name_prefix" {
  type        = string
  description = "S3 bucket name prefix; random suffix is appended"
  default     = "day28-s3"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,40}$", var.bucket_name_prefix))
    error_message = "bucket_name_prefix must be 3-40 chars using lowercase letters, numbers, and hyphens."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags applied to all resources"
  default     = {}
}
