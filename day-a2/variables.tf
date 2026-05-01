variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ca-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.1.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet (different AZ)."
  type        = string
  default     = "10.1.3.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
  default     = "10.1.2.0/24"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    Project     = "30-days-of-terraform"
    Environment = "Dev"
    Day         = "A2"
  }
}
