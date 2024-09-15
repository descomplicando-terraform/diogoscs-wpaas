module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.9.0"

  identifier = var.identifier

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = 5

  db_name  = var.db_name
  username = var.username
  port     = var.port

  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window = var.maintenance_window
  
  backup_window      = var.backup_window
  backup_retention_period = var.backup_retention_period

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade

  # Database Deletion Protection
  deletion_protection = var.deletion_protection

  # DB subnet group
  create_db_subnet_group = var.create_db_subnet_group
  subnet_ids             = var.subnet_ids
  db_subnet_group_name = var.db_subnet_group_name

  # DB parameter group
  create_db_parameter_group = var.create_db_parameter_group
  parameter_group_name      = var.parameter_group_name
  family                    = var.family
  parameters                = var.parameters

  # DB option group
  create_db_option_group = var.create_db_option_group
  option_group_name      = var.option_group_name
  options                = var.options
  major_engine_version   = var.major_engine_version

  tags = var.tags

}
