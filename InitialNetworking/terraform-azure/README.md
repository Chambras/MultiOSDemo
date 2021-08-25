[![Terraform-Azure-Networking](https://github.com/Chambras/MultiOSDemo/actions/workflows/terraform-azure-networking.yml/badge.svg)](https://github.com/Chambras/MultiOSDemo/actions/workflows/terraform-azure-networking.yml)

# Initial Azure Networking

Creates the initial resources to be used later on.

It creates the following resources:

- A New Resource Group.
- A VNet with some Subnets.
- A Storage account to store VM logs.

## Project Structure

This project has the following files which make them easy to reuse, add or remove.

```ssh
.
├── LICENSE
├── README.md
├── main.tf
├── networking.tf
├── outputs.tf
├── storage.tf
└── variables.tf
```

Most common parameters are exposed as variables in _`*variables.tf`_ files.

## Pre-requisites

It is assumed that you have azure CLI and Terraform installed and configured.
More information on this topic [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure). I recommend using a Service Principal with a certificate.

### versions

This terraform script has been tested using the following versions:

- Terraform = 1.0.5
- Azure provider = 2.73.0
- Azure CLI 2.27.2

## Usage

Just run these commands to initialize terraform, get a plan and approve it to apply it.

```ssh
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

I also recommend using a remote state instead of a local one. You can change this configuration in _`main.tf`_
You can create a free Terraform Cloud account [here](https://app.terraform.io).

## Clean resources

It will destroy everything that was created.

```ssh
terraform destroy --force
```

## Caution

Be aware that by running this script your account might get billed.

## Authors

- Marcelo Zambrana
