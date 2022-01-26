data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name                 = var.vpc_name
  cidr                 = "10.0.0.0/16"
  azs                  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    application = "gg_demo"
  }

  public_subnet_tags = {
    "application" = "gg_demo"
  }

  private_subnet_tags = {
    "application" = "gg_demo"
  }
}

module myip {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

resource "aws_security_group" "gg_demo_sg" {
  name_prefix = "gg-demo-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["${module.myip.address}/32"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "From VPC"

    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port = 1521
    to_port   = 1521
    protocol  = "tcp"
    description = "Oracle RDS"

    cidr_blocks = ["${module.myip.address}/32"]
  }

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    description = "Postgresql RDS"

    cidr_blocks = ["${module.myip.address}/32"]
  }

  ingress {
    from_port = 9001
    to_port   = 9030
    protocol  = "tcp"
    description = "GG Microservices"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    application = "gg_demo"
  }
}
