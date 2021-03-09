#internet gateway
resource "aws_route_table" "coalfire-igw-routetable" {
  vpc_id = aws_vpc.coalfire-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.coalfire-gateway.id
  }

  tags = {
    Name = "coalfire-igw-routetable"
  }
}

resource "aws_route_table_association" "coalfire-igw-rta" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.coalfire-igw-routetable.id
}

resource "aws_internet_gateway" "coalfire-gateway" {
  vpc_id = aws_vpc.coalfire-vpc.id

  tags = {
    Name = "coalfire-gateway"
  }
}




#NAT gateway
resource "aws_eip" "nat-eip" {
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.sub2.id

  tags = {
    Name = "coalfire-nat-gateway"
  }
}


resource "aws_route_table" "coalfire-nat-routetable" {
  vpc_id = aws_vpc.coalfire-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "coalfire-nat-routetable"
  }
}

resource "aws_route_table_association" "coalfire-nat-rta" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.coalfire-nat-routetable.id
}
