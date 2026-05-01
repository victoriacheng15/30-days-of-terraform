output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.web.dns_name
}

output "ec2_private_ip" {
  description = "The private IP of the EC2 instance."
  value       = aws_instance.web.private_ip
}

output "secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret."
  value       = aws_secretsmanager_secret.db_password.arn
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet."
  value       = aws_subnet.private.id
}
