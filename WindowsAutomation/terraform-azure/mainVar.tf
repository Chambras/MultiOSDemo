variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  type        = string
  default     = "MZV"
  description = "To be added at the beginning of each resource."
}

variable "tags" {
  type = map(any)
  default = {
    "Environment" = "Demo"
    "Project"     = "Hashicorp"
    "BillingCode" = "Internal"
    "Customer"    = "CSU"
  }
  description = "Tags to be applied to all resources."
}

#Main Network RG
variable "mainNetworkRG" {
  type        = string
  default     = "MZVMainNetwork"
  description = "Main Nework resource group name."

}

variable "winRG" {
  type        = string
  default     = "winDevVMs"
  description = "Windows Servers Resource Group Name."
}
