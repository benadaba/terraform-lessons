resource "aws_security_group" "allow_tls-tf" {
  name        = "allow_tls-wf-tf"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_tf_vpc.id


  #   dynamic ingress {
  #     iterator = port
  #     for_each = var.ingress_ports_map
  #     content {
  #         description = port.key
  #         from_port        = port.value
  #         to_port          = port.value
  #         protocol         = "tcp"
  #         cidr_blocks      = ["0.0.0.0/0"] 
  #     }

  #   }


  dynamic "ingress" {
    # iterator = port
    for_each = var.ingress_ports
    content {
      description = ingress.key
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }


  egress {
    from_port   = var.ingress_ports_map["all"]
    to_port     = var.ingress_ports_map["all"]
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_tls"
  }
}


# #list datatype. var.ingress_ports[1]
# variable "ingress_ports" {
#   description = "port numbers for security group"
#   type = list(number)
#   default = [80,8080, 443, 22, 0, 3306]
# }
