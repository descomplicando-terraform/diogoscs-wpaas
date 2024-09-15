module "vote_service_sg" {
  source = "../../repo-aws-modules/security-group"

  name        = "${local.name}-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks      = ["10.10.1.0/24"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  ingress_with_source_security_group_id = [ {
    source_security_group_id = module.vote_service_sg2.security_group_id
    from_port = 1000
    to_port = 1002
    protocol = "tcp"
    description = "App 1"
  },
  {
    source_security_group_id = module.vote_service_sg2.security_group_id
    rule = "mysql-tcp"
  } ]
  egress_with_cidr_blocks = [
    {
    cidr_blocks = "0.0.0.0/0"
    from_port = -1
    to_port = -1
    protocol = -1
    description = "Outbound packets"
  }]
  
}

module "vote_service_sg2" {
  source = "../../repo-aws-modules/security-group"

  name        = "${local.name}-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks      = ["10.10.1.0/24"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
    ingress_with_source_security_group_id = [ {
    source_security_group_id = module.vote_service_sg.security_group_id
    from_port = 1000
    to_port = 1002
    protocol = "tcp"
  } ]
}