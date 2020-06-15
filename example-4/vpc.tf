## creating vpc with cidr block

resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terra_vpc"
  }
}

## creating private & public subnets

resource "aws_subnet" "pub_subnet" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terravpc_pub_sunet"
  }
}

resource "aws_subnet" "pri_subnet" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "terravpc_pri_subnet"
  }
}

## creating internet gateway & attached to public subnet

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  tags = {
    Name = "terravpc_igw"
  }
}


#creating route-table & attached to internet-gatewat,map to public subnet


resource "aws_route_table" "rt-ig" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "terravpc-rt-ig"
  }
}
resource "aws_route_table_association" "rt-sa-pub" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.rt-ig.id
}


########## Creating EIP,NAT-gateway & map to private subnet

# creating eip
resource "aws_eip" "nat-eip" {
  vpc = true
}

#creating natgateway

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${aws_subnet.pub_subnet.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

# creating route table
resource "aws_route_table" "rt-nat" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id

  }
  tags = {
    Name = "terravpc-rt-ngw"
  }
}

resource "aws_route_table_association" "rt-sa-pri" {
  subnet_id      = aws_subnet.pri_subnet.id
  route_table_id = aws_route_table.rt-nat.id
}

############ security group for terra_vpc
resource "aws_security_group" "terravpc-sg" {
  name        = "terravpc-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.terra_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terra_vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
