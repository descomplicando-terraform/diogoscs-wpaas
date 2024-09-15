module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id


  # Source ingress cidr blocks with pre defined rules
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.ingress_rules
  # Source ingress cidr blocks
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  # Source ingress SG Ids
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id


  # Source egress cidr blocks with pre defined rules
  egress_cidr_blocks = var.egress_cidr_blocks
  egress_rules       = var.egress_rules
  # Source egress cidr blocks
  egress_with_cidr_blocks = var.egress_with_cidr_blocks
  # Source egress SG Ids
  egress_with_source_security_group_id = var.egress_with_source_security_group_id

}