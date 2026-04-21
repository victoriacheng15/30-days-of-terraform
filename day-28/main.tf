terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      environment = var.environment
      project     = "30-days-of-opentofu"
      day         = "28"
      cloud       = "aws"
    },
    var.common_tags
  )
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name_prefix}-${random_string.bucket_suffix.result}"
  tags   = local.tags
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "s3_read_write" {
  statement {
    sid    = "AllowListBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.main.arn
    ]
  }

  statement {
    sid    = "AllowObjectReadWrite"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.main.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_rw" {
  name        = "day28-s3-rw-${random_string.bucket_suffix.result}"
  description = "Day 28 S3 read/write policy"
  policy      = data.aws_iam_policy_document.s3_read_write.json

  tags = local.tags
}
