variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ca-central-1"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    Project     = "30-days-of-terraform"
    Environment = "Dev"
    Day         = "A4"
  }
}
