variable "vpc_name" {
  type = string
  default = "myvpc"
}

variable "pub_sub_name" {
  type = string
  default = "my-public-sub"
}

variable "pub_sub_cidr" {
  type = list
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "pri_sub_name" {
  type = string
  default = "my-private-sub"
}

variable "pri_sub_cidr" {
  type = list
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "igw_name" {
  type = string
  default = "my-igw" 
}
variable "az_sub" {
  type = string
  default = "us-east-1a"
}