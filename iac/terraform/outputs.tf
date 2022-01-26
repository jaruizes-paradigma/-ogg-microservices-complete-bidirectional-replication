output "vpc_id" {
  value = module.vpc.id
}

output "oracle_ggma_public_ip" {
  value = module.goldengate.goldengate_microservices_public_ip
}
output "oracle_ggma_private_ip" {
  value = module.goldengate.goldengate_microservices_private_ip
}

//output "oracle_ggc_postgresql_public_ip" {
//  value = module.goldengate.goldengate_classic_postgresql_public_ip
//}
//
//output "oracle_ggc_postgresql_private_ip" {
//  value = module.goldengate.goldengate_classic_postgresql_private_ip
//}

output "postgresql_endpoint" {
  value = module.rds.postgresql_endpoint
}

output "oracle_endpoint" {
  value = module.rds.oracle_endpoint
}
