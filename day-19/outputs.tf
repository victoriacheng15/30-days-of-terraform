output "frontdoor_endpoint_hostname" {
  description = "Default hostname of Azure Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.fd.host_name
}

output "frontdoor_profile_id" {
  description = "Resource ID of Azure Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.fd.id
}

output "frontdoor_url" {
  description = "HTTPS URL for the Front Door endpoint"
  value       = "https://${azurerm_cdn_frontdoor_endpoint.fd.host_name}"
}

output "waf_policy_mode" {
  description = "Mode configured on the Front Door WAF policy"
  value       = azurerm_cdn_frontdoor_firewall_policy.waf.mode
}
