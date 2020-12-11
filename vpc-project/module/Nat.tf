########## Creating EIP,NAT-gateway & map to private subnet

# creating eip
resource "aws_eip" "nat-eip" {
  vpc = true
}

#creating natgateway

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${aws_subnet.public_subnet-1.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

# creating route table
resource "aws_route_table" "rt-nat" {
  vpc_id = "${aws_vpc.project_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id

  }
  tags = {
    Name = "project-rt-ngw"
  }
}

resource "aws_route_table_association" "rt-sa-private" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.rt-nat.id
}
