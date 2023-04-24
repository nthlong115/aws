variable "ami" {
  default = "ami-069aabeee6f53e7bf"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}

variable "aws_subnet_id" {
  type = string
}

variable "aws_sg_id" {
  type = string
}

variable "pub_ip" {
  type = bool
}

variable "place_name" {
  type = string
  default = "hunky-dory-pg"
}

variable "place_strategy" {
  type = string
  default = "cluster"
}
variable "key_pair_name" {
  type = string
  default = "my-ssh-key-2"
}