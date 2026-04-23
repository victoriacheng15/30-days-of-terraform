output "ec2_instance_id" {
  value       = aws_instance.web.id
  description = "EC2 instance ID"
}

output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "EC2 public IP address"
}

output "security_group_id" {
  value       = aws_security_group.web.id
  description = "Security group ID attached to EC2"
}

output "iam_role_arn" {
  value       = aws_iam_role.ec2_instance_role.arn
  description = "IAM role ARN attached to EC2 instance profile"
}

output "default_vpc_id" {
  value       = data.aws_vpc.default.id
  description = "Default VPC ID used for deployment"
}
