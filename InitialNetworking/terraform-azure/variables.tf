variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  type        = string
  default     = "MZV"
  description = "Suffix to use in all resources."
}

variable "mainRGName" {
  type        = string
  default     = "DevNetwork"
  description = "VNet Resource Group Name."
}

variable "tags" {
  type = map(any)
  default = {
    "Environment" = "Demo"
    "Project"     = "Hashicorp"
    "BillingCode" = "Internal"
    "Customer"    = "CSU"
  }
}

## Networking variables
variable "vnetName" {
  type        = string
  default     = "Dev"
  description = "VNet name."
}

variable "publicSubnetName" {
  type        = string
  default     = "public"
  description = "Public subnet name."
}

locals {
  base_cidr_block = "10.70.0.0/16"
}

## Storage
variable "storageAccountName" {
  type        = string
  default     = "mzvmainstoragelogs"
  description = "BTS Cluster Storage Account."
}
