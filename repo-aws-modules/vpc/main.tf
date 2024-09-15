data "aws_availability_zones" "available" {}
data "aws_region" "current" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = var.name
  cidr = var.cidr

  azs = var.azs

  public_subnets      = var.public_subnets
  public_subnet_names = var.public_subnet_names

  private_subnets      = var.private_subnets
  private_subnet_names = var.private_subnet_names

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  create_database_subnet_group = var.create_database_subnet_group
  database_subnet_group_name   = var.database_subnet_group_name
  database_subnet_group_tags   = var.database_subnet_group_tags

  tags = var.tags

}