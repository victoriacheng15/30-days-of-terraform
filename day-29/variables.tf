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

variable "instance_type" {
  type        = string
  description = "EC2 instance size"
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR block allowed for SSH access"
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  type        = string
  description = "CIDR block allowed for HTTP access"
  default     = "0.0.0.0/0"
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags applied to all resources"
  default     = {}
}
