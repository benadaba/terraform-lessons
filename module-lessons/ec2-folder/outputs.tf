output "publicIPAddress" {
  value = aws_instance.my-dp-local-ec2-name[0].public_ip
}

output "already-prepared-ami" {
  value = data.aws_ami.ubuntu_ami.id
}