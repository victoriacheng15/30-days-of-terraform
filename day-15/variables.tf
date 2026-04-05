variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-day-15-private-aks"
}

variable "cluster_name" {
  description = "The name of the private AKS cluster."
  type        = string
  default     = "aks-day-15-private"
}

variable "dns_prefix" {
  description = "The DNS prefix for the cluster."
  type        = string
  default     = "aksday15private"
}

variable "vnet_address_space" {
  description = "Address space for the VNet."
  type        = list(string)
  default     = ["10.15.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "Address prefix for the AKS subnet."
  type        = list(string)
  default     = ["10.15.1.0/24"]
}

variable "vm_size" {
  description = "The size of the virtual machine for the nodes."
  type        = string
  default     = "Standard_D2s_v3"
}
