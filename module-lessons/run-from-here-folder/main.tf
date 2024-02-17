module "my-ec2-infra"{
    source = "../ec2-folder"
    num-ec2-instaces-to-create = var.my-own-num-instance
    instance-type-for-region="t2.medium"
    key_name_2 = "new-key-pair"
}

output "public_ip-from-mod-file" {
  value = module.my-ec2-infra.publicIPAddress
}


output "ami-we-got-from-our-hardwork" {
  value = module.my-ec2-infra.already-prepared-ami
}

# resource "aws_instance" "web" {
#   ami           = module.my-ec2-infra.already-prepared-ami
#   instance_type = "t3.micro"
  

#   tags = {
#     Name = "HelloWorld"
#   }
# }