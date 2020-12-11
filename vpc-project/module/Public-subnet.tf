## creating 2 public subnets

resource "aws_subnet" "public_subnet-1" {
  vpc_id     = "${aws_vpc.project_vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_subnet-1"
  }
}


resource "aws_subnet" "public-subnet-2" {
  vpc_id     = "${aws_vpc.project_vpc.id}"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_subnet-2"
  }
}
