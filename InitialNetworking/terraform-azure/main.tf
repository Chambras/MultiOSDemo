terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "Hashicorp-InitialNetwork"
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

resource "azurerm_resource_group" "mainRGName" {
  name     = "${var.suffix}${var.mainRGName}"
  location = var.location
  tags     = var.tags
}
