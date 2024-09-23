variable "name" {
  description = ""
  type        = string
}

variable "cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "prd_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "prd_public_subnets_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "prd_private_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "prd_private_subnets_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "prd_public_subnets_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "prd-public"
}

variable "prd_private_subnets_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "prd-private"
}

variable "dev_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "dev_public_subnets_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "dev_private_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "dev_private_subnets_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "dev_public_subnets_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "dev-public"
}

variable "dev_private_subnets_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "dev-private"
}

variable "create_prd_private_dbsubnet_group" {
  type        = bool
  description = ""
  default = true
}

variable "create_dev_private_dbsubnet_group" {
  type        = bool
  description = ""
  default = true
}

variable "env_prd" {
  type        = string
  description = ""
  default = "prd"
}

variable "env_dev" {
  type        = string
  description = ""
  default = "dev"
}