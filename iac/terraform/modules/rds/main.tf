resource "aws_db_parameter_group" "postgresql-pg" {
  name        = "gg-demo-postgresql-pg"
  description = "Parameters for Postgresql (GoldenGate Demo)"
  family      = "postgres12"

  parameter {
    apply_method = "pending-reboot"
    name = "rds.logical_replication"
    value = "1"
  }
}

resource "aws_db_parameter_group" "oracle-19-pg" {
  name = "gg-demo-oracle-pg"
  description = "Parameters for Oracle (GoldenGate Demo)"
  family = "oracle-se2-19"

  parameter {
    apply_method = "pending-reboot"
    name = "enable_goldengate_replication"
    value = "TRUE"
  }
}


module "postgresql" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.0.0"

  identifier = "gg-demo-postgresql"

  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.t3.medium"
  family               = "postgres12"

  allocated_storage     = 20
  storage_encrypted     = false

  name     = "ggdemo"
  username = "postgres"
  password = "postgres"
  port     = 5432

  multi_az               = false
  subnet_ids             = var.vpc_public_subnets
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible = true

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  create_monitoring_role                = false
  create_db_parameter_group = false
  parameter_group_name = aws_db_parameter_group.postgresql-pg.name

  tags = {
    application = "gg_demo"
  }

}

module "oracledb" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.0.0"

  identifier = "gg-demo-oracle"

  engine               = "oracle-se2"
  engine_version       = "19.0.0.0.ru-2021-01.rur-2021-01.r2"
  major_engine_version = "19"
  instance_class       = "db.t3.medium"
  family               = "oracle-se2-19"
  license_model        = "license-included"

  allocated_storage     = 100
  storage_encrypted     = false

  name     = "ggdemo"
  username = "oracledb"
  password = "oracledb"
  port     = 1521

  multi_az               = false
  subnet_ids             = var.vpc_public_subnets
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = true

  backup_retention_period = 1  // Enable backups to enable ARCHIVELOG
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"

  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  create_monitoring_role                = false
  create_db_parameter_group = false
  parameter_group_name = aws_db_parameter_group.oracle-19-pg.name

  character_set_name = "AL32UTF8"

  tags = {
    application = "gg_demo"
  }

}
