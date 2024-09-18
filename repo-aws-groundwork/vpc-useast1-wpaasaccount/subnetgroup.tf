/*module "subnetgroup_priv_prd" {
  source      = "../../repo-aws-modules/rds/subnetgroup"
  name        = suubnet_private_prd
  description = "Subnet Privada de PRD"
  subnet_ids = [for subnet in module.vpc_useast1_wpaasaccount.priva : subnet if startswith(subnet, "PRD-PRIV")]

  tags = {
    environment = "prd"
  }

}

module "subnetgroup_priv_dev" {
  source      = "../../repo-aws-modules/rds/subnetgroup"
  name        = suubnet_private_dev
  description = "Subnet Privada de DEV"
  subnet_ids = [  ]

  tags = {
    environment = "dev"
  }

}*/