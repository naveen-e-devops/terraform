resource "aws_security_group" "myterraform_sg" {

  name        = "myterra_sg"
  description = "allow all trafic"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

  }
  tags = {
    Name = "my-terra-sg"
  }
}
