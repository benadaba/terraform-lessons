
#Resource Block 3

resource "aws_security_group" "my-own-local-name" {
  name        = "my-security-group-name-dp"
  description = "Allow TLS inbound traffic"

#inbound
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


#outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
