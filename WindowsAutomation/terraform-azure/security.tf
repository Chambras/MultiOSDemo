resource "azurerm_network_security_group" "devOpsrdpNSG" {
  name                = "${var.suffix}${var.sgName}"
  location            = azurerm_resource_group.winRG.location
  resource_group_name = azurerm_resource_group.winRG.name

  security_rule {
    name                       = var.nsgDetails["rdp"].name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["rdp"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}
