resource "aws_ebs_volume" "vol" {
  availability_zone = var.zone-a
  size              = 1

  tags = {
    Name = "vol"
  }
}
