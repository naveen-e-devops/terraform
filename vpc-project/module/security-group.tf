############ security group for terra_vpc
resource "aws_security_group" "project-sg" {
  name        = "project-sg"
  description = "Allow inbound traffic"
  vpc_id      = "${aws_vpc.project_vpc.id}"

  ingress {
    description = "project from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.project_vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-sg"
  }
}
