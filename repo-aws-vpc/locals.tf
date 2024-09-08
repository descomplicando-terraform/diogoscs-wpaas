locals {
  name   = "vpc-wpaas"
  region = "us-east-1"

  vpc_cidr = "10.1.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  public_subnets        = ["10.1.10.0/24", "10.1.12.0/24", "10.1.14.0/24", "10.1.20.0/24", "10.1.22.0/24", "10.1.24.0/24"]
  public_subnets_names  = ["PRD-PUBL-A", "PRD-PUBL-B", "PRD-PUBL-C", "DEV-PUBL-A", "DEV-PUBL-B", "DEV-PUBL-C"]
  
  private_subnets       = ["10.1.11.0/24", "10.1.13.0/24", "10.1.15.0/24", "10.1.21.0/24", "10.1.23.0/24", "10.1.25.0/24"]
  private_subnets_names = ["PRD-PRIV-A", "PRD-PRIV-B", "PRD-PRIV-C", "DEV-PRIV-A", "DEV-PRIV-B", "DEV-PRIV-C"]


  tags = {
    git-hub-repo = "terraform-aws-vpc"
    managed-by   = "terraform"
    project      = "wpaas"
  }
}