output "ip" {
  value = module.ec2.public_ip
}

output "id" {
  value = module.ec2.id
}

output "private_id" {
  value = module.ec2.private_ip
}