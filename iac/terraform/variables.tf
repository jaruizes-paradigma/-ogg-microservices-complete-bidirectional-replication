variable "vpc_name" {
  type = string
  description = "VPC name"
  default = "gg_demo_vpc"
}

variable "rhel_ami" {
  description = "RHEL AMI identifier"
  type        = string
  default     = "ami-0ec23856b3bad62d3"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}