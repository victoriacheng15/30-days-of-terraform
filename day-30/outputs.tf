output "traffic_manager_fqdn" {
  value       = azurerm_traffic_manager_profile.global.fqdn
  description = "Global Traffic Manager DNS name"
}

output "traffic_manager_profile_id" {
  value       = azurerm_traffic_manager_profile.global.id
  description = "Traffic Manager profile resource ID"
}

output "azure_primary_endpoint_target" {
  value       = azurerm_linux_web_app.primary.default_hostname
  description = "Azure primary endpoint target registered in Traffic Manager"
}

output "aws_secondary_endpoint_target" {
  value       = azurerm_traffic_manager_external_endpoint.aws_secondary.target
  description = "AWS secondary endpoint target registered in Traffic Manager"
}

output "azure_web_app_default_hostname" {
  value       = azurerm_linux_web_app.primary.default_hostname
  description = "Azure Web App hostname used as primary endpoint"
}

output "aws_ec2_instance_id" {
  value       = aws_instance.secondary.id
  description = "AWS EC2 instance ID used as secondary endpoint"
}

output "aws_ec2_public_ip" {
  value       = aws_instance.secondary.public_ip
  description = "AWS EC2 public IP used as secondary endpoint"
}

output "route53_record_fqdn" {
  value       = var.create_route53_record ? aws_route53_record.traffic_manager_cname[0].fqdn : null
  description = "Route53 record FQDN when create_route53_record is enabled"
}
