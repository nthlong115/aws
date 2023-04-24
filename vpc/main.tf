resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  #enable_dns_hostname, dns_support
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.pub_sub_cidr)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.pub_sub_cidr,count.index)}"
  map_public_ip_on_launch = true
  availability_zone       = var.az_sub
  tags = {
    Name = "${var.vpc_name}-Public-subnet-${count.index+1}"
  }
}
#theem az cho subnet
resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.pri_sub_cidr)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.pri_sub_cidr,count.index)}"
  map_public_ip_on_launch = false
  availability_zone       = var.az_sub
  tags = {
    Name = "${var.vpc_name}-Private-subnet-${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-Internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-Rote-table"
  }
}

resource "aws_route_table_association" "subnet_associate" {
  subnet_id      = aws_subnet.public_subnet.0.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elasticIP.id
  subnet_id     = aws_subnet.public_subnet.0.id 
  tags = {
    Name = "${var.vpc_name}-Nat-gateway"
  }
}

resource "aws_eip" "elasticIP" {
  vpc = true 
  tags = {
    Name = "${var.vpc_name}-ElasticIp"
  }
}

resource "aws_route_table" "route_table_nat" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-Route-Nat"
  }
}

resource "aws_route_table_association" "subnet_associate_nat" {
  subnet_id      = aws_subnet.private_subnet.0.id
  route_table_id = aws_route_table.route_table_nat.id
}

resource "aws_route" "route_nat" {
  route_table_id         = aws_route_table.route_table_nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route" "route_inside_vpc" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
