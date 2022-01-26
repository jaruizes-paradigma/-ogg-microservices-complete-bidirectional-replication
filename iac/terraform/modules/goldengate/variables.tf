variable "security_group_id" {
  description = "Oracle Security Group"
  type        = string
}

variable "vpc_public_subnets" {
  description = "The list of the public subnets"
  type        = list(string)
}

variable "rhel_ami" {
  description = "RHEL AMI identifier"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

