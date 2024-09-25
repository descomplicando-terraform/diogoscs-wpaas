locals {
  default-tags = {
    managed-by  = "terraform"
    project     = var.name
    environment = var.environment
  }
}

#########################
# SUBNET GROUP SETTINGS #
#########################
locals {
  db_subnet_group_name = var.create_db_subnet_group ? try(aws_db_subnet_group.this[0].name, null) : var.db_subnet_group_name
}

resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0

  name        = var.db_subnet_group_name
  subnet_ids  = var.subnet_group_ids
  description = var.db_subnet_group_description

  tags = merge(
    var.tags,
    local.default-tags
  )
}

############################
# PARAMETER GROUP SETTINGS #
############################
locals {
  parameter_group_name_id = var.create_db_parameter_group ? try(aws_db_parameter_group.this[0].id, null) : var.db_parameter_group_name
}

resource "aws_db_parameter_group" "this" {
  count       = var.create_db_parameter_group ? 1 : 0
  name        = var.db_parameter_group_name
  family      = var.db_parameter_group_family
  description = var.db_parameter_group_description

  dynamic "parameter" {
    for_each = var.db_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    var.tags,
    local.default-tags
  )
}

#########################
# OPTION GROUP SETTINGS #
#########################
locals {
  option_group = var.create_db_option_group ? try(aws_db_option_group.this[0].id, null) : var.db_option_group_name
}
resource "aws_db_option_group" "this" {
  count = var.create_db_option_group ? 1 : 0

  name                     = var.db_option_group_name
  option_group_description = var.option_group_description
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version

  dynamic "option" {
    for_each = var.options
    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
  }

  tags = merge(
    var.tags,
    local.default-tags
  )
}

###########################
# SECURITY GROUP SETTINGS #
###########################
resource "aws_security_group" "this" {
  count = var.create_security_group ? 1 : 0

  name        = "${var.identifier}-sg"
  vpc_id      = var.vpc_id
  description = "SG for RDS ${var.identifier}"

  tags = merge(
    var.tags,
    local.default-tags
  )
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if var.create_security_group }

  # required
  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, var.port)
  to_port           = try(each.value.to_port, var.port)
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.this[0].id

  # optional
  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}

################
# RDS SETTINGS #
################
resource "aws_db_instance" "this" {

  identifier        = var.identifier
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id
  license_model     = var.license_model

  db_name                             = var.db_name
  username                            = var.username != "" ? var.username : (var.create_db_secrets ? jsondecode(aws_secretsmanager_secret_version.db_credentials[0].secret_string)["username"] : "")
  password                            = var.manage_master_user_password ? null : (var.password != "" ? var.password : (var.create_db_secrets ? jsondecode(aws_secretsmanager_secret_version.db_credentials[0].secret_string)["password"] : ""))
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  custom_iam_instance_profile         = var.custom_iam_instance_profile
  manage_master_user_password         = !local.is_replica && var.manage_master_user_password ? var.manage_master_user_password : null
  master_user_secret_kms_key_id       = !local.is_replica && var.manage_master_user_password ? var.master_user_secret_kms_key_id : null

  vpc_security_group_ids = compact(concat([try(aws_security_group.this[0].id, "")], var.vpc_security_group_ids))
  db_subnet_group_name   = local.db_subnet_group_name
  parameter_group_name   = local.parameter_group_name_id
  option_group_name      = local.option_group
  network_type           = var.network_type

  availability_zone   = var.availability_zone
  multi_az            = var.multi_az
  iops                = var.iops
  storage_throughput  = var.storage_throughput
  publicly_accessible = var.publicly_accessible
  ca_cert_identifier  = var.ca_cert_identifier

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window

  snapshot_identifier   = var.snapshot_identifier
  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null

  replicate_source_db     = var.replicate_source_db
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  max_allocated_storage   = var.max_allocated_storage
  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = var.monitoring_interval > 0 ? local.monitoring_role_arn : null

  character_set_name              = var.character_set_name
  nchar_character_set_name        = var.nchar_character_set_name
  timezone                        = var.timezone
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups

  dynamic "restore_to_point_in_time" {
    for_each = var.restore_to_point_in_time != null ? [var.restore_to_point_in_time] : []

    content {
      restore_time                             = lookup(restore_to_point_in_time.value, "restore_time", null)
      source_db_instance_automated_backups_arn = lookup(restore_to_point_in_time.value, "source_db_instance_automated_backups_arn", null)
      source_db_instance_identifier            = lookup(restore_to_point_in_time.value, "source_db_instance_identifier", null)
      source_dbi_resource_id                   = lookup(restore_to_point_in_time.value, "source_dbi_resource_id", null)
      use_latest_restorable_time               = lookup(restore_to_point_in_time.value, "use_latest_restorable_time", null)
    }
  }
  
  tags = merge(
    var.tags,
    local.default-tags
  )
}

################################################################################
# ENHANCED MONITORING
################################################################################
locals {
  monitoring_role_arn         = var.create_monitoring_role ? aws_iam_role.enhanced_monitoring[0].arn : var.monitoring_role_arn
  monitoring_role_name        = var.monitoring_role_name
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  name                 = local.monitoring_role_name
  assume_role_policy   = data.aws_iam_policy_document.enhanced_monitoring.json
  description          = var.monitoring_role_description
  permissions_boundary = var.monitoring_role_permissions_boundary

  tags = {
    "Name" = format("%s", var.monitoring_role_name),
  tags = merge(
    var.tags,
    local.default-tags
  )
}
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
