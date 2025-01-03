resource "aws_instance" "jenkins" {
  ami             = var.instance.ami
  instance_type   = var.instance.type_load
  key_name        = aws_key_pair.ec2-keypair.key_name
  security_groups = [aws_security_group.jenkins-sg.name]

  connection {
    user        = "ubuntu"
    private_key = tls_private_key.ec2-keypair.private_key_openssh
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../userdata/jenkins-setup.sh"
    destination = "/home/ubuntu/jenkins-setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/jenkins-setup.sh",
      "sudo /home/ubuntu/jenkins-setup.sh"
    ]
  }
  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "sonar" {
  ami             = var.instance.ami
  instance_type   = var.instance.type_load
  key_name        = aws_key_pair.ec2-keypair.key_name
  security_groups = [aws_security_group.sonar-sg.name]

  connection {
    user        = "ubuntu"
    private_key = tls_private_key.ec2-keypair.private_key_openssh
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../userdata/sonar-setup.sh"
    destination = "/home/ubuntu/sonar-setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/sonar-setup.sh",
      "sudo /home/ubuntu/sonar-setup.sh"
    ]
  }
  tags = {
    Name = "sonar"
  }
}

resource "aws_instance" "nexus" {
  ami             = "ami-0df2a11dd1fe1f8e3" # centOS
  instance_type   = var.instance.type_load
  key_name        = aws_key_pair.ec2-keypair.key_name
  security_groups = [aws_security_group.nexus-sg.name]

  connection {
    user        = "ec2-user"
    private_key = tls_private_key.ec2-keypair.private_key_openssh
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../userdata/nexus-setup.sh"
    destination = "/home/ec2-user/nexus-setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ec2-user/nexus-setup.sh",
      "sudo /home/ec2-user/nexus-setup.sh"
    ]
  }
  tags = {
    Name = "nexus"
  }
}