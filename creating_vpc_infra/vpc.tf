resource "aws_vpc" "main_tf_vpc" {
  cidr_block           = var.my-vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = local.tags["vpc"]
  }
}


#public subnet 1 
resource "aws_subnet" "public_subnet-1" {
  vpc_id     = aws_vpc.main_tf_vpc.id
  cidr_block = var.pub-sub1-cidr

  tags = {
    Name = local.tags["pub-sub-1"]
  }
}

#public sub 1 rtb association
resource "aws_route_table_association" "public-sub-1-assoc" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

#public subnet 2
resource "aws_subnet" "public_subnet-2" {
  vpc_id     = aws_vpc.main_tf_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = local.tags["pub-sub-2"]
  }
}

#public sub 2 rtb association
resource "aws_route_table_association" "public-sub-2-assoc" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public-rt.id
}

#private subnet 1
resource "aws_subnet" "private_subnet-1" {
  vpc_id     = aws_vpc.main_tf_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private_subnet-1-tf"
  }
}


#private sub 1 rtb association
resource "aws_route_table_association" "private-sub-1-assoc" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.private-rt.id
}

#private subnet 2
resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.main_tf_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet-2-tf"
  }
}

#private sub 1 rtb association
resource "aws_route_table_association" "private-sub-2-assoc" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.private-rt.id
}

# public route table 
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main_tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt-tf"
  }
}


# private route table 
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main_tf_vpc.id

  #    route {
  #     cidr_block = "0.0.0.0/0"
  #     nat_gateway_id = aws_nat_gateway.ngw.id
  #   }

  tags = {
    Name = "private-rt-tf"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_tf_vpc.id

  tags = {
    Name = "igw-tf"
  }
}


#nat gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip-tf.id
  subnet_id     = aws_subnet.public_subnet-1.id

  tags = {
    Name = "ngw-tf"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_eip" "eip-tf" {
#   domain = "vpc"
  tags = {
    Name = "dp-eip-tf"
  }
}



#route association for nat gateway and private route table
resource "aws_route" "nat-assoc-wf-priv-rtb" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

