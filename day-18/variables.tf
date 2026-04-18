variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-day18-appgw-waf"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "West US 2"
}

variable "app_gateway_name" {
  description = "Name of the Application Gateway"
  type        = string
  default     = "appgw-day18-waf"
}

variable "app_gateway_capacity" {
  description = "Instance count for Application Gateway WAF_v2"
  type        = number
  default     = 1
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.18.0.0/16"]
}

variable "appgw_subnet_prefixes" {
  description = "Address prefixes for the dedicated Application Gateway subnet"
  type        = list(string)
  default     = ["10.18.1.0/24"]
}

variable "web_backend_fqdn" {
  description = "FQDN for the default web backend"
  type        = string
  default     = "example.com"
}

variable "api_backend_fqdn" {
  description = "FQDN for the API backend routed from /api/* paths"
  type        = string
  default     = "www.example.com"
}

variable "enable_https" {
  description = "Enable HTTPS listener and SSL termination on Application Gateway"
  type        = bool
  default     = false
}

variable "ssl_certificate_data" {
  description = "Base64-encoded PFX certificate data used when enable_https is true"
  type        = string
  default     = ""

  validation {
    condition     = var.enable_https ? length(var.ssl_certificate_data) > 0 : true
    error_message = "ssl_certificate_data must be provided when enable_https is true."
  }
}

variable "ssl_certificate_password" {
  description = "Password for the PFX certificate used when enable_https is true"
  type        = string
  default     = ""
  sensitive   = true

  validation {
    condition     = var.enable_https ? length(var.ssl_certificate_password) > 0 : true
    error_message = "ssl_certificate_password must be provided when enable_https is true."
  }
}
