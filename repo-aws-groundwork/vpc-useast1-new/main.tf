locals {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

module "groundwork" {
  source = "../../repo-aws-modules/new_vpc"

  # GENERAL SETTINGS
  name = "wpaas"

  ## Primeiras AZs disponiveis na região
  azs = slice(data.aws_availability_zones.available.names, 0, 3)


  # VPC SETTINGS
  cidr_block = "10.2.0.0/16"

  # SUBNET SETTINGS
  prd_public_subnets       = ["10.2.1.0/24", "10.2.2.0/24"]
  prd_public_subnets_names = ["prd-publ-a", "prd-publ-b"]

  prd_private_subnets       = ["10.2.3.0/24", "10.2.4.0/24", "10.2.5.0/24"]
  prd_private_subnets_names = ["prd-priv-a", "prd-priv-b"]

  dev_public_subnets       = ["10.2.11.0/24", "10.2.12.0/24"]
  dev_public_subnets_names = ["dev-publ-a", "dev-publ-b"]

  dev_private_subnets       = ["10.2.13.0/24", "10.2.14.0/24", "10.2.15.0/24"]
  dev_private_subnets_names = ["dev-priv-a", "dev-priv-b"]

  create_prd_private_dbsubnet_group = true
  create_dev_private_dbsubnet_group = true

  tags = {
    git-hub-repo = "repo-aws-modules"
  }

}
