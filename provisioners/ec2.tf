
#1ST  EC2 INSTANCE ( eventually acting as TARGET)
resource "aws_instance" "my-dp-local-ec2-name" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance-type-for-region
  vpc_security_group_ids = [aws_security_group.my-own-local-name.id]
  key_name = var.default-key-pair
  tags = {
    Name = "my-ec2-instance-created-with-tf-1"
  }

#executes the command on your local computer
  provisioner "local-exec" {
      command = "dir"
  }
}



# remote exec within resource being craeted (self)
#2ND  EC2 INSTANCE 
resource "aws_instance" "illustrate-remote-exec" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance-type-for-region
  vpc_security_group_ids = [aws_security_group.my-own-local-name.id]
  key_name = var.default-key-pair
  tags = {
    Name = "my-ec2-remote-exec"
  }

#executes the command on your local computer
  provisioner "remote-exec" {
      inline = ["mkdir -p FOLDER-CREATED-WITH-PROVISIONER-REMOTE"]

      connection {
        type = "ssh"
        host = self.public_ip
        private_key = file("${path.module}/datapandas-devops-keypair.pem")
        user = var.user
        timeout = "1m"
      }
  }

}



# #Resource Block 3
# #3rd  EC2 INSTANCE 
# resource "aws_instance" "make-changes-to-other-ec2" {
#   ami           = data.aws_ami.ubuntu_ami.id
#   instance_type = var.instance-type-for-region
#   key_name = var.default-key-pair
#   tags = {
#     Name = "make-changes-to-other-ec2"
#   }

# #executes the command on your remote machine
#   provisioner "remote-exec" {
#       inline = ["mkdir -p FOLDER-CREATED-WITH-PROVISIONER-CREATED-FROM-ANOTHER-INSTANCE"]

#       connection {
#         type = "ssh"
#         host = aws_instance.my-dp-local-ec2-name.public_ip #target instance
#         private_key = file("${path.module}/datapandas-devops-keypair.pem") #for target instance
#         user = var.user
#         timeout = "1m"
#       }
#   }
# }


resource "null_resource" "does-not-create-anything"{

 #executes the command on your remote machine
  provisioner "remote-exec" {
    #   inline = ["mkdir -p FOLDER-NULL-NULL-NULL"]
      script =  "createf.sh"

      connection {
        type = "ssh"
        host = aws_instance.my-dp-local-ec2-name.public_ip #target instance
        private_key = file("${path.module}/datapandas-devops-keypair.pem") #for target instance
        user = var.user
        timeout = "1m"
      }
  }
}


#mnull resource on local
resource "null_resource" "for-my-local-exec" {
     provisioner "local-exec" {
      command = "mkdir null-resource-folder"

  }
}


#mnull resource on local
resource "null_resource" "for-my-file-prov" {

     provisioner "file" {
      source = "createf.sh"
      destination = "/tmp/iamhere.sh"


      connection {
        type = "ssh"
        host = aws_instance.my-dp-local-ec2-name.public_ip #target instance
        private_key = file("${path.module}/datapandas-devops-keypair.pem") #for target instance
        user = var.user
        timeout = "1m"
      }

  }
}



#TERRAFORM 
# terraform import RESOURCE_TYPE.NAME ID

resource "aws_instance" "manually-created" {
  # (resource arguments)
  ami = "ami-09885f3ec1667cbfc"
  instance_type  = "t2.micro"
  tags = {
    Name = "manually-created"
  }

}


resource "aws_instance" "man-2" {
  ami = "ami-09885f3ec1667cbfc"
  instance_type = "t2.micro"
   tags = {
    Name = "man-2"
  }
}