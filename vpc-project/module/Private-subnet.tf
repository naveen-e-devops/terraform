# creating 3 private subnets 


resource "aws_subnet" "private_subnet-1" {
  vpc_id     = "${aws_vpc.project_vpc.id}"
  cidr_block = "10.0.11.0/24"

  tags = {
    Name = "private_subnet-1"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id     = "${aws_vpc.project_vpc.id}"
  cidr_block = "10.0.12.0/24"

  tags = {
    Name = "private_subnet-2"
  }
}

resource "aws_subnet" "private_subnet-3" {
  vpc_id     = "${aws_vpc.project_vpc.id}"
  cidr_block = "10.0.13.0/24"

  tags = {
    Name = "private_subnet-3"
  }
}
