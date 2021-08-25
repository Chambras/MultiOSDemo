output "mainRGName" {
  value = azurerm_resource_group.mainRGName.name
}

output "vNetName" {
  value = azurerm_virtual_network.genericVNet.name
}
