terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "Hashicorp-Windows"
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

# Networking RG
data "azurerm_resource_group" "mainNetowrkRG" {
  name = var.mainNetworkRG
}

# Azure DevOps RG
resource "azurerm_resource_group" "winRG" {
  name     = "${var.suffix}${var.winRG}"
  location = var.location

  tags = var.tags
}
