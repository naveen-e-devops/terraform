# creating Internet Gateway 

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.project_vpc.id}"

  tags = {
    Name = "project_igw"
  }
}
