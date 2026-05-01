output "account_id" {
  description = "The AWS Account ID being used."
  value       = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  description = "The AWS ARN of the caller identity."
  value       = data.aws_caller_identity.current.arn
}

output "lab_user_arn" {
  description = "The ARN of the newly created IAM user."
  value       = aws_iam_user.lab_user.arn
}

output "lab_access_key_id" {
  description = "The Access Key ID for the lab user."
  value       = aws_iam_access_key.lab_key.id
}

output "lab_secret_access_key" {
  description = "The Secret Access Key (SENSITIVE)."
  value       = aws_iam_access_key.lab_key.secret
  sensitive   = true
}
