output "s3_bucket_name" {
  value       = aws_s3_bucket.main.bucket
  description = "S3 bucket name"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.main.arn
  description = "S3 bucket ARN"
}

output "iam_policy_arn" {
  value       = aws_iam_policy.s3_rw.arn
  description = "IAM policy ARN for S3 read/write"
}
