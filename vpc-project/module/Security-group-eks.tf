resource "aws_security_group" "eks" {
  name        = "terraform-eks"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.project_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      aws_subnet.private_subnet-1.cidr_block,
      aws_subnet.private_subnet-2.cidr_block,
      aws_subnet.private_subnet-3.cidr_block
    ]
  }
}
