











#Resource Block 3
/*
resource "aws_security_group" "my-own-local-name" {
  name        = "my-security-group-name-dp"
  description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#inbound
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
    description = "http"
    from_port        = port.value
    to_port          = port.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }


  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
    description = "http"
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }


#outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
*/