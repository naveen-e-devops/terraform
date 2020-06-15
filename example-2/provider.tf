provider "aws" {
  region = var.region
}


resource "aws_instance" "web" {

  ami             = var.ami
  instance_type   = var.instance-type
  security_groups = ["myterra_sg"]
  key_name        = "sahoj"

  tags = {

    Name = "web"
  }

}
