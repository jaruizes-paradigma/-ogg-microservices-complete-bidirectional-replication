data "template_file" "ggc_userdata" {
  template = file("${path.module}/userdata/ggma_userdata.sh")
}

//data "template_file" "gg_postgresql_userdata" {
//  template = file("${path.module}/userdata/gg_psql_userdata.sh")
//}

resource "aws_key_pair" "gg_demo_instance_key" {
  key_name   = "gg_demo"
  public_key = file("${path.module}/../../../ssh/ssh_gg.pub")

  tags = {
    application = "gg_demo"
  }
}

resource "aws_instance" "goldengate_microservices" {
  ami           = var.rhel_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.vpc_public_subnets[0]
  key_name = aws_key_pair.gg_demo_instance_key.key_name

  user_data = data.template_file.ggc_userdata.rendered

  root_block_device {
    volume_size = 30
  }

  tags = {
    application = "gg_demo",
    Name = "GG Microservices (GG DEMO)"
  }
}

//resource "aws_instance" "goldengate_postgresql" {
//  ami           = var.rhel_ami
//  instance_type = var.ec2_instance_type
//  vpc_security_group_ids = [var.security_group_id]
//  subnet_id = var.vpc_public_subnets[0]
//  key_name = aws_key_pair.gg_demo_instance_key.key_name
//
//  user_data = data.template_file.gg_postgresql_userdata.rendered
//
//  tags = {
//    application = "gg_demo",
//    Name = "GG Classic Postgresql (GG DEMO)"
//  }
//}
