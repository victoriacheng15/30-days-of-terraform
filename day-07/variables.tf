variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-day-07-project"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "West US 2"
}

variable "storage_account_name" {
  type        = string
  description = "Must be globally unique, all lowercase, 3-24 chars"
  default     = "tofuproject07"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Lab"
    Day         = "07"
    Project     = "StaticWebsite"
  }
}
