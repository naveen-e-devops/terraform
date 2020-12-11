###creating route-table & attached to internet-gatewat,map to public_subnet-1


resource "aws_route_table" "rt-ig" {
  vpc_id = "${aws_vpc.project_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "project-rt-ig"
  }
}
resource "aws_route_table_association" "rt-sa-pub" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.rt-ig.id
}

