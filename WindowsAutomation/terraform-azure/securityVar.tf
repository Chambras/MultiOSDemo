## Security variables
variable "sgName" {
  type        = string
  default     = "rdpNSG"
  description = "Default Security Group Name to be applied by default to Windows VMs."
}

variable "sourceIPs" {
  type        = list(string)
  default     = ["173.66.39.236"]
  description = "Public IPs to allow inboud communications."
}

# Using Maps
variable "nsgDetails" {
  type = map(map(string))
  default = {
    rdp = {
      name = "RDP"
      port = "3389"
    }
  }
  description = "Map of rules to be created."
}
