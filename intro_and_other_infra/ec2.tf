
# #Resource Block 1
# resource "aws_instance" "my-dp-local-ec2-name" {
#   # ami           = "ami-093cb9fb2d34920ad" # eu-west-2
#   ami           = var.my-ami #us-west-2
#   instance_type = var.instance-type-for-region
#   key_name = var.default-key-pair
#   user_data = file("${path.module}/scripts/userdatascript1.sh")
#   subnet_id = aws_subnet.public-subnet.id
#   # user_data = 
#   tags = {
#     Name = "my-ec2-instance-created-with-tf-usrd"
#   }
# }





