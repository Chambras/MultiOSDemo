# Create Public IP
resource "azurerm_public_ip" "devOpsPublicIP" {
  name                = "${var.suffix}${var.winVMName}"
  location            = azurerm_resource_group.winRG.location
  resource_group_name = azurerm_resource_group.winRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

# Create NIC with internal IP
resource "azurerm_network_interface" "devOpsNI" {
  name                = "${var.suffix}${var.winVMName}"
  location            = azurerm_resource_group.winRG.location
  resource_group_name = azurerm_resource_group.winRG.name

  ip_configuration {
    name                          = "windowsconfiguration"
    subnet_id                     = data.azurerm_subnet.devSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devOpsPublicIP.id
  }

  tags = var.tags
}

# Associate SG to NIC
resource "azurerm_network_interface_security_group_association" "devOpsSG" {
  network_interface_id      = azurerm_network_interface.devOpsNI.id
  network_security_group_id = azurerm_network_security_group.devOpsrdpNSG.id
}

# Creating Az DevOps VM
resource "azurerm_windows_virtual_machine" "devOpsVM" {
  name                  = "${var.suffix}${var.winVMName}"
  resource_group_name   = azurerm_resource_group.winRG.name
  location              = azurerm_resource_group.winRG.location
  size                  = var.vmSize
  admin_username        = var.vmUserName
  admin_password        = var.password
  network_interface_ids = [azurerm_network_interface.devOpsNI.id, ]

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                 = "${var.suffix}${var.winVMName}OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.osDisk
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windowsSKU
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = data.azurerm_storage_account.mainSA.primary_blob_endpoint
  }

  tags = var.tags
}

# Domain join running as domain join extension
resource "azurerm_virtual_machine_extension" "DevOpsJoinDomain" {
  name = "${var.suffix}${var.winVMName}"
  #location = "${var.location}"
  #resource_group_name = "${var.vm_resource_group}"
  virtual_machine_id         = azurerm_windows_virtual_machine.devOpsVM.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
			{
			"Name": "M365x735935.onmicrosoft.com",
			"OUPath": "${var.non_prod_ou}",
			"User": "${var.ldapbind_account}",
			"Restart": "true",
			"Options": "3"
			}
		SETTINGS
  protected_settings         = <<PROTECTED_SETTINGS
		{
		"Password": "${var.ldapbind_pw}"
		}
		PROTECTED_SETTINGS
  depends_on                 = [azurerm_windows_virtual_machine.devOpsVM]
}
