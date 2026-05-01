output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = aws_db_instance.main.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.main.id
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket."
  value       = aws_s3_bucket.main.id
}

output "cloudwatch_alarm_arn" {
  description = "The ARN of the CloudWatch metric alarm."
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "db_secret_arn" {
  description = "The ARN of the RDS secret in Secrets Manager."
  value       = aws_secretsmanager_secret.db_credentials.arn
}
