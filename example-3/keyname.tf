resource "aws_key_pair" "web" {

  key_name   = var.keyname
  public_key = file("sshkey.pub")

}
