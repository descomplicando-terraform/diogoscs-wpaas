locals {
  region = "us-east-1"
}


module "rds_wpaas_prd" {
  source = "../../repo-aws-modules/new_rds"

  # GENERAL SETTINGS
  name        = "wpaas"
  environment = "prd"
  vpc_id      = ""
  identifier  = ""

  # SUBNET GROUP SETTINGS
  create_db_subnet_group = false
  db_subnet_group_name   = "COLOCARONOME"

  # PARAMETER GROUP SETTINGS
  create_db_parameter_group = true
  db_parameter_group_name   = "rds-pg"
  db_parameter_group_family = "mysql5.6"

  # OPTION GROUP SETTINGS
  create_db_option_group = true
  db_option_group_name   = "rds-pg"
  major_engine_version   = "mysql5.6"
  engine                 = "mysql"

  # SECURITY GROUP SETTINGS
  create_security_group = true

  tags = {
    git-hub-repo = "repo-aws-modules"
  }

}