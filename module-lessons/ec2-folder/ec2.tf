#Resource Block 1
resource "aws_instance" "my-dp-local-ec2-name" {
  # ami           = "ami-093cb9fb2d34920ad" # eu-west-2
  ami           = data.aws_ami.ubuntu_ami.id
  count = var.num-ec2-instaces-to-create # 0,1,2,3 count.index
  instance_type = var.instance-type-for-region
  key_name = data.aws_key_pair.example.key_name
  # user_data = file("${path.module}/scripts/userdatascript1.sh")
  # subnet_id = aws_subnet.public_subnet-1.id
  # vpc_security_group_ids = [aws_security_group.allow_tls-tf.id]
  # user_data = 
  tags = {
    Name = "${local.ec2_tag_Name}-${count.index}"

  }
}



