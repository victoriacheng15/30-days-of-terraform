variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-day19-frontdoor"
}

variable "location" {
  description = "Azure region for the resource group (Front Door remains a global edge service)"
  type        = string
  default     = "eastus"
}

variable "frontdoor_profile_name" {
  description = "Name of the Azure Front Door profile"
  type        = string
  default     = "fdp-day19-global"
}

variable "frontdoor_endpoint_name" {
  description = "Name of the Azure Front Door endpoint"
  type        = string
  default     = "fde-day19-global"
}

variable "waf_policy_name" {
  description = "Name of the Front Door WAF policy"
  type        = string
  default     = "wafday19frontdoor"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9]{0,127}$", var.waf_policy_name))
    error_message = "waf_policy_name must start with a letter and contain only letters and numbers (1-128 chars)."
  }
}

variable "primary_origin_host" {
  description = "Primary backend hostname (for example, app-primary.azurewebsites.net)"
  type        = string
  default     = "example.com"
}

variable "secondary_origin_host" {
  description = "Secondary backend hostname for failover"
  type        = string
  default     = "www.example.com"
}
