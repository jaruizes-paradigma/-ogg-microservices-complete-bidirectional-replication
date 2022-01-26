output "postgresql_endpoint" {
  description = "Postgresql endpoint"
  value       = module.postgresql.db_instance_endpoint
}

output "oracle_endpoint" {
  description = "Oracle endpoint"
  value       = module.oracledb.db_instance_endpoint
}