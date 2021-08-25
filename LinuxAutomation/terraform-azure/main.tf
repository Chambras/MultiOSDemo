terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "Hashicorp-Linux"
    }
  }
  required_version = "= 1.0.5"
  required_providers {
    azurerm = "= 2.73.0"
  }
}

provider "azurerm" {
  features {}
}

# Network RG
data "azurerm_resource_group" "mainRG" {
  name = var.mainRGName
}

resource "azurerm_resource_group" "devVMRG" {
  name     = "${var.suffix}${var.devVMRGName}"
  location = var.location
  tags     = var.tags
}
