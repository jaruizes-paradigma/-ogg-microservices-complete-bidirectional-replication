variable "vpc_public_subnets" {
  description = "The list of the public subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group"
  type        = string
}

