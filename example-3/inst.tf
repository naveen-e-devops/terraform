resource "aws_instance" "web" {

  instance_type   = "t2.micro"
  security_groups = [var.firewall]
  key_name        = aws_key_pair.web.key_name
  ami             = var.ami

  tags = {

    Name = "web"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh",
    ]
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("sshkey")
    host        = self.private_ip
  }
}


