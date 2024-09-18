variable "name" {
  description = "Name of subnetgroup"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnets"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}