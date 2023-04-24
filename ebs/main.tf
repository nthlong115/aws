resource "aws_ebs_volume" "aws_ebs" {
  size = 30
  availability_zone = "us-east-1a"
  type = "gp2"
  tags = {
    Name = "MyEBS"
  }
}

resource "aws_volume_attachment" "to_pub_ec2" {
  device_name = "vol1"
  volume_id = aws_ebs_volume.aws_ebs.id
  instance_id = var.outec2
}