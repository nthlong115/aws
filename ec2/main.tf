resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.ec2_type
  subnet_id = var.aws_subnet_id
  vpc_security_group_ids = [ "${var.aws_sg_id}" ]
  associate_public_ip_address = var.pub_ip
  key_name = aws_key_pair.ec2_keypair.key_name
  tags = {
    Name = "ec2-in-${var.aws_sg_id}"
  }
}

resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}
resource "local_file" "local_key_pair" {
  filename = "${var.key_pair_name}.pem"
  file_permission = "0400"
  content = tls_private_key.ec2_ssh_key.private_key_pem
}
/*resource "aws_placement_group" "lab" {
  name     = "hunky-dory-pg"
  strategy = "cluster"
}*/

#keypair