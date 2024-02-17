output "ec2-ip-address"{
    description = "the ip address of the ec2 created"
    value =  "id: ${aws_instance.my-dp-local-ec2-name.id}  - ip: ${aws_instance.my-dp-local-ec2-name.public_ip}"
}

output "check-vpc-dns-enabled" {
    description = "dns of "
    value = aws_vpc.vpc-created-with-tf.enable_dns_hostnames
}


output "your-own-wording"{
    value = aws_vpc.vpc-created-with-tf.cidr_block
}