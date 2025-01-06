resource "tls_private_key" "ec2-keypair" {
  algorithm = var.keypair.algorithm
}
resource "local_file" "private_key_pem" {
  content  = tls_private_key.ec2-keypair.private_key_openssh
  filename = "${var.keypair.name}.pem"

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
  }
}
resource "aws_key_pair" "ec2-keypair" {
  key_name   = "${var.keypair.name}-${random_pet.random.id}"
  public_key = tls_private_key.ec2-keypair.public_key_openssh
}