resource "aws_vpc" "its-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "its-vpc"
  }
}

resource "aws_subnet" "its-sub-pub" {
  count                   = 2
  vpc_id                  = aws_vpc.its-vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.AZS[count.index]

  tags = {
    Name = "its-sub-pub-${count.index + 1}"
  }
}

resource "aws_subnet" "its-sub-priv-1" {
  vpc_id     = aws_vpc.its-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "its-sub-priv-1"
  }
}

resource "aws_internet_gateway" "its-igw" {
  vpc_id = aws_vpc.its-vpc.id

  tags = {
    Name = "its-igw"
  }
}

resource "aws_eip" "its-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "its-nat-gw" {
  allocation_id = aws_eip.its-eip.id
  subnet_id     = aws_subnet.its-sub-pub[0].id

  tags = {
    Name = "its-nat-gw"
  }
}

resource "aws_route_table" "its-pub-rt" {
  vpc_id = aws_vpc.its-vpc.id

  route {
    cidr_block = var.ALL_IPS_BLOCK
    gateway_id = aws_internet_gateway.its-igw.id
  }

  tags = {
    Name = "its-pub-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.its-sub-pub[0].id
  route_table_id = aws_route_table.its-pub-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.its-sub-pub[1].id
  route_table_id = aws_route_table.its-pub-rt.id
}

resource "aws_route_table" "its-priv-rt" {
  vpc_id = aws_vpc.its-vpc.id

  route {
    cidr_block     = var.ALL_IPS_BLOCK
    nat_gateway_id = aws_nat_gateway.its-nat-gw.id
  }

  tags = {
    Name = "its-priv-rt"
  }
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.its-sub-priv-1.id
  route_table_id = aws_route_table.its-priv-rt.id
}