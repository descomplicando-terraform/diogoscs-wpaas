locals {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

module "vpc_useast1_wpaasaccount" {
  source = "../../repo-aws-modules/vpc"

  name = "vpc-wpaas"

  cidr = "10.1.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  public_subnets      = ["10.1.10.0/24", "10.1.12.0/24", "10.1.14.0/24", "10.1.20.0/24", "10.1.22.0/24", "10.1.24.0/24"]
  public_subnet_names = ["PRD-PUBL-A", "PRD-PUBL-B", "PRD-PUBL-C", "DEV-PUBL-A", "DEV-PUBL-B", "DEV-PUBL-C"]

  private_subnets      = ["10.1.11.0/24", "10.1.13.0/24", "10.1.15.0/24", "10.1.21.0/24", "10.1.23.0/24", "10.1.25.0/24"]
  private_subnet_names = ["PRD-PRIV-A", "PRD-PRIV-B", "PRD-PRIV-C", "DEV-PRIV-A", "DEV-PRIV-B", "DEV-PRIV-C"]

  enable_nat_gateway = true
  single_nat_gateway = true

  create_database_subnet_group = false

  tags = {
    git-hub-repo = "repo-aws-modules"
    managed-by   = "terraform"
  }

}