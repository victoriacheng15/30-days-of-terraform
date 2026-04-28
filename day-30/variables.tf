variable "aws_region" {
  type        = string
  description = "AWS region for EC2 and Route53 resources"
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

variable "azure_location" {
  type        = string
  description = "Azure region for Traffic Manager resource group"
  default     = "canadacentral"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name for Day 30 resources"
  default     = "rg-day30-multicloud"
}

variable "traffic_manager_profile_name" {
  type        = string
  description = "Traffic Manager profile name"
  default     = "tm-day30-global"
}

variable "traffic_manager_dns_prefix" {
  type        = string
  description = "Traffic Manager DNS relative name prefix; random suffix is appended"
  default     = "day30-global"
}

variable "azure_webapp_name_prefix" {
  type        = string
  description = "Prefix for Azure Linux Web App name; random suffix is appended"
  default     = "app-day30"
}

variable "azure_app_service_sku" {
  type        = string
  description = "SKU for Azure App Service Plan"
  default     = "B1"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS EC2 instance size for secondary endpoint"
  default     = "t3.micro"
}

variable "allowed_http_cidr" {
  type        = string
  description = "CIDR block allowed for HTTP access to AWS secondary endpoint"
  default     = "0.0.0.0/0"
}

variable "create_route53_record" {
  type        = bool
  description = "Whether to create a Route53 CNAME record pointing to Traffic Manager"
  default     = false
}

variable "route53_zone_id" {
  type        = string
  description = "Route53 hosted zone ID (required when create_route53_record is true)"
  default     = ""

  validation {
    condition     = var.create_route53_record ? length(trim(var.route53_zone_id)) > 0 : true
    error_message = "route53_zone_id must be set when create_route53_record is true."
  }
}

variable "route53_record_name" {
  type        = string
  description = "Route53 record name for the Traffic Manager CNAME (required when create_route53_record is true)"
  default     = ""

  validation {
    condition     = var.create_route53_record ? length(trim(var.route53_record_name)) > 0 : true
    error_message = "route53_record_name must be set when create_route53_record is true."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags applied to all resources"
  default     = {}
}
