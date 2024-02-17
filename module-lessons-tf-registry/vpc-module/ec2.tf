#Resource Block 1
resource "aws_instance" "my-dp-local-ec2-name" {
  ami           = data.aws_ami.ubuntu_ami.id
  count = 2 
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.example.key_name
  subnet_id = module.vpc.public_subnets[0]
  
  tags = {
    Name = "created-with-vpc-tf-registry-${count.index}"

  }
}


