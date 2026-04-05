variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-day-14-aks-scaling"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-day-14-scaling"
}

variable "dns_prefix" {
  description = "The DNS prefix for the cluster."
  type        = string
  default     = "aksday14scaling"
}

variable "vm_size" {
  description = "The size of the virtual machine for the nodes."
  type        = string
  default     = "Standard_D2s_v3"
}

# Day 14: Scaling Variables
variable "min_count" {
  description = "Minimum number of nodes for the cluster."
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum number of nodes for the cluster."
  type        = number
  default     = 3
}
