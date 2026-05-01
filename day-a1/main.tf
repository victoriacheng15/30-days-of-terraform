terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Verify Current Identity (The "Handshake")
data "aws_caller_identity" "current" {}

# 2. Create a restricted IAM User
resource "aws_iam_user" "lab_user" {
  name = "day-a1-lab-user"
  tags = var.tags
}

# 3. Create a custom Read-Only Policy for S3 (as an example)
resource "aws_iam_policy" "s3_read_only" {
  name        = "DayA1S3ReadOnly"
  description = "A lab policy to demonstrate AWS IAM permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:Get*", "s3:List*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# 4. Attach the Policy to the User
resource "aws_iam_user_policy_attachment" "attach_s3" {
  user       = aws_iam_user.lab_user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

# 5. (Optional) Generate Access Keys - Note: This is for lab demonstration only!
resource "aws_iam_access_key" "lab_key" {
  user = aws_iam_user.lab_user.name
}
