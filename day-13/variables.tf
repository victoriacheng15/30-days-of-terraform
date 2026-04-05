variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-day-13-aks"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-day-13-baseline"
}

variable "dns_prefix" {
  description = "The DNS prefix for the cluster."
  type        = string
  default     = "aksday13baseline"
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the virtual machine for the nodes."
  type        = string
  default     = "Standard_D2s_v3"
}
