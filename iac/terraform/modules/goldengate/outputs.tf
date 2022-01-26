output "goldengate_microservices_public_ip" {
  description = "Oracle GG Microservices public IP"
  value       = aws_instance.goldengate_microservices.public_ip
}

output "goldengate_microservices_private_ip" {
  description = "Oracle GG Microservices private IP"
  value       = aws_instance.goldengate_microservices.private_ip
}

//output "goldengate_classic_postgresql_public_ip" {
//  description = "Oracle GGC Postgresql public IP"
//  value       = aws_instance.goldengate_postgresql.public_ip
//}
//
//output "goldengate_classic_postgresql_private_ip" {
//  description = "Oracle GGC Postgresql private IP"
//  value       = aws_instance.goldengate_postgresql.private_ip
//}
