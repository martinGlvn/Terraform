# vpc
resource "aws_vpc" "martin_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev-vpc"
  }
}
# Subnet
resource "aws_subnet" "martin_public_subnet" {
  vpc_id                  = aws_vpc.martin_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "dev-public"
  }
}
# Internet Gateway 
resource "aws_internet_gateway" "martin_internet_gatewat" {
  vpc_id = aws_vpc.martin_vpc.id
  tags = {
    Name = "dev-igw"
  }
}
# Route Table
resource "aws_route_table" "martin_public_rt" {
  vpc_id = aws_vpc.martin_vpc.id
  tags = {
    Name = "dev_public_rt"
  }
}
#Route
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.martin_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.martin_internet_gatewat.id
}
#Route Table Subnet
resource "aws_route_table_association" "martin_public_assoc" {
  subnet_id      = aws_subnet.martin_public_subnet.id
  route_table_id = aws_route_table.martin_public_rt.id
}
#Security Group
resource "aws_security_group" "martin_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.martin_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = -1
    cidr_block = ["0.0.0.0/0"]
  }
}

#Key Pair
resource "aws_key_pair" "martin_auth" {
  key_name   = "martinkey"
  public_key = file("~/.ssh/martinkey.pub")
}