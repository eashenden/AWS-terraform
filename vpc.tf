# Create a VPC
resource "aws_vpc" "coalfire-vpc" {
  cidr_block         = "10.0.0.0/16"
  enable_dns_support = true

  tags = {
    Name = "coalfire-vpc"
  }
}

#Accessible from internet
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.coalfire-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}${var.az-b}"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub1"
  }
}

#Accessible from internet
resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.coalfire-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}${var.az-c}"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub2"
  }
}

#Not accessible from internet
resource "aws_subnet" "sub3" {
  vpc_id            = aws_vpc.coalfire-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}${var.az-c}"

  tags = {
    Name = "sub3"
  }
}

#Not accessible from internet
resource "aws_subnet" "sub4" {
  vpc_id            = aws_vpc.coalfire-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}${var.az-b}"

  tags = {
    Name = "sub4"
  }
}
