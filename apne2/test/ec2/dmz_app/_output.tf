output "ips" {
  value = module.ec2.*.public_ip
}

output "ids" {
  value = module.ec2.*.id
}

output "private_ids" {
  value = module.ec2.*.private_ip
}