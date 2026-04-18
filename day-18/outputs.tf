output "application_gateway_public_ip" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.appgw.ip_address
}

output "application_gateway_frontend_url" {
  description = "Frontend URL for the Application Gateway"
  value       = "${var.enable_https ? "https" : "http"}://${azurerm_public_ip.appgw.ip_address}"
}

output "waf_policy_id" {
  description = "Resource ID of the WAF policy attached to Application Gateway"
  value       = azurerm_web_application_firewall_policy.waf.id
}

output "path_routing_rule_name" {
  description = "Name of the path-based request routing rule"
  value       = one([for rule in azurerm_application_gateway.appgw.request_routing_rule : rule.name if rule.name == "path-routing-rule"])
}
