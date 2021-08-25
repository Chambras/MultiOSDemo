output "winRG" {
  value       = azurerm_resource_group.winRG.name
  description = "Azure DevOps Resource Group."
  sensitive   = false
}

# VM Information
# Azure DevOps Server
output "DevOpsPublicIP" {
  value = azurerm_public_ip.devOpsPublicIP.ip_address
}

output "DevOpsPrivateIP" {
  value = azurerm_network_interface.devOpsNI.private_ip_address
}

output "VMName" {
  value = azurerm_windows_virtual_machine.devOpsVM.name
}
