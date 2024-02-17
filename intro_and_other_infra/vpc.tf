locals {
  ec2_tag_Name = "${var.my-current-region}-my-ec2"
  vpc_tag_Name  = "vpc_created_with_tf-${random_integer.priority.result}-${data.aws_region.current.name}"
}

resource "random_integer" "priority" {
  min = 1
  max = 10
}

#Resource Block 1
resource "aws_instance" "my-dp-local-ec2-name" {
  # ami           = "ami-093cb9fb2d34920ad" # eu-west-2
  ami           = var.my-ami #us-west-2
  instance_type = var.instance-type-for-region
  key_name = var.default-key-pair
  user_data = file("${path.module}/scripts/userdatascript1.sh")
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls-tf.id]
  # user_data = 
  tags = {
    Name = local.ec2_tag_Name

  }
}


resource "aws_instance" "my-dp-local-ec2-name-2" {
  # ami           = "ami-093cb9fb2d34920ad" # eu-west-2
  ami           = var.my-ami #us-west-2
  instance_type = var.instance-type-for-region
  # key_name = var.default-key-pair
  key_name = data.aws_key_pair.example.key_name
  user_data = file("${path.module}/scripts/userdatascript1.sh")
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls-tf.id]
  # public_ip = 
  # user_data = 
  tags = {
    Name = "my-ec2-instance-created-with-tf-usr-CHECK"
  }
}



resource "aws_instance" "my-dp-local-ec2-name-3" {
  # ami           = "ami-093cb9fb2d34920ad" # eu-west-2
  ami           =  data.aws_ami.ubuntu_ami.id
  instance_type = var.instance-type-for-region
  # key_name = var.default-key-pair
  key_name = data.aws_key_pair.example.key_name
  user_data = file("${path.module}/scripts/userdatascript1.sh")
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls-tf.id]
  # public_ip = 
  # user_data = 
  tags = {
    Name = "my-ec2-instance-created-with-tf-usr-3"
  }
}

#Resource Block 2
resource "aws_vpc" "vpc-created-with-tf" {
  enable_dns_hostnames = var.enable_dns
  enable_dns_support = var.enable_dns_support
  cidr_block = "10.0.0.0/16"
   tags = {
    Name = local.vpc_tag_Name
  }
}


resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.vpc-created-with-tf.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-with-tf"
  }
}


resource "aws_security_group" "allow_tls-tf" {
  name        = "allow_tls-wf-tf"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc-created-with-tf.id
   

  ingress {
    description = "http"
    from_port        = var.ingress_ports_map["http"]
    to_port          = var.ingress_ports_map["http"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description = "https"
    from_port        =var.ingress_ports_map["https"]
    to_port          = var.ingress_ports_map["https"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port        = var.ingress_ports_map["ssh"]
    to_port          = var.ingress_ports_map["ssh"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description = "ssh"
    from_port        = var.ingress_ports_map["ssh"]
    to_port          = var.ingress_ports[5] 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "jenkins"
    from_port        = var.ingress_ports_map["jenkins"]
    to_port          = var.ingress_ports_map["jenkins"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "sonar"
    from_port        = var.ingress_ports_map["sonar"]
    to_port          = var.ingress_ports_map["sonar"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = var.ingress_ports_map["all"] 
    to_port          = var.ingress_ports_map["all"] 
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_tls-tf2" {
  name        = "allow_tls-wf-tf"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc-created-with-tf.id
   

#dynamic
  dynamic "ingress" {
    for_each = var.ingress_ports_map
    content {
    description = "http"
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  #  ingress {
  #   description = "https"
  #   from_port        =var.ingress_ports_map["https"]
  #   to_port          = var.ingress_ports_map["https"]
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "ssh"
  #   from_port        = var.ingress_ports_map["ssh"]
  #   to_port          = var.ingress_ports_map["ssh"]
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  #  ingress {
  #   description = "ssh"
  #   from_port        = var.ingress_ports_map["ssh"]
  #   to_port          = var.ingress_ports[5] 
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "jenkins"
  #   from_port        = var.ingress_ports_map["jenkins"]
  #   to_port          = var.ingress_ports_map["jenkins"]
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "sonar"
  #   from_port        = var.ingress_ports_map["sonar"]
  #   to_port          = var.ingress_ports_map["sonar"]
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  egress {
    from_port        = var.ingress_ports_map["all"] 
    to_port          = var.ingress_ports_map["all"] 
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_tls"
  }
}


#list datatype. var.ingress_ports[1]
variable "ingress_ports" {
  description = "port numbers for security group"
  type = list(number)
  default = [80,8080, 443, 22, 0, 3306]
}


#map datatype. var.ingress_ports_map["http"], var.ingress_ports_map["jenkins"]
variable "ingress_ports_map" {
  description = "port numbers for security group"
  type = map(number)
  default = {
     "http" = 80,
     "jenkins" = 8080, 
     "https" = 443, 
     "ssh" = 22, 
     "all" = 0, 
     "rds" = 3306
     "sonar" = 9000
     }
}


# variable "ingress_ports_http" {
#   description = "port numbers for security group"
#   type = number
#   default = 80
# }


# variable "ingress_ports_https" {
#   description = "port numbers for security group"
#   type = number
#   default = 443
# }

variable "enable_dns"{
  type = bool
  default = true
}

variable "enable_dns_support"{
  type = bool
  default = true
}