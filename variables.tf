variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "prefix" {
  type        = string
  default     = "test"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  default     = "azureuser"
  description = "The admin username for the virtual machines."
}

variable "windows_admin_username" {
  type        = string
  default     = "azureuser"
  description = "The admin username for the Windows virtual machine."
}

variable "subscription_id"{
type = string
description = "Azure subscription id"
sensitive = true
}