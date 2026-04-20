variable "name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region for the resource group"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the resource group"
  default     = {}
}
