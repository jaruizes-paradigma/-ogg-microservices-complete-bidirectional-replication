terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
}

module "goldengate" {
  source = "./modules/goldengate"
  security_group_id = module.vpc.security_group
  vpc_public_subnets = module.vpc.public_subnets
  ec2_instance_type = var.ec2_instance_type
  rhel_ami = var.rhel_ami
}

module "rds" {
  source = "./modules/rds"
  security_group_id = module.vpc.security_group
  vpc_public_subnets = module.vpc.public_subnets
}
