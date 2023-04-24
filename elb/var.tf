/*variable "alb_group" {
  type = object({
    target_type         = string,
    name                = string, 
    protocol            = string,
    port                = number,
    path                = string,
    healthy_threshold   = number,
    unhealthy_threshold = number,
    timeout             = number,
    interval            = number,
  })
}*/
variable "albg_target_type" {
  type = string
  default = "instance"
}
variable "albg_name" {
  type = string
  default = "appLb"
}
variable "albg_protocol" {
  type = string
  default = "HTTP"
}
variable "albg_port" {
  type = number
  default = 80
}
variable "albg_path" {
  type = string
  default = "/"
}
variable "albg_healthy_threshold" {
  type = number
  default = 5
}
variable "albg_unhealthy_threshold" {
  type = number
  default = 2
}
variable "albg_timeout" {
  type = number
  default = 6
}
variable "albg_interval" {
  type = number
  default = 10
}
variable "lb_vpc_id" {
  type = string
}

/*variable "alb" {
  type = object({
   name               = string,
   internal           = bool,
   load_balancer_type = string,
  })
}*/
variable "alb_i_name" {
  type = string
  default = "alb"
}
variable "alb_i_interval" {
  type = bool
  default = false
}
variable "alb_i_load_balancer_type" {
  type = string
  default = "application"
}
variable "lb_sg" {
  type = list
}
variable "lb_subnet" {
  type = list
}

/*variable "lb_listener" {
  type = object({
    protocol          = string,
    port              = number,
    type              = string,
  })
}*/
variable "lb_lis_protocol" {
  type = string
  default = "HTTP"
}
variable "lb_lis_port" {
  type = number
  default = 80
}  
variable "lb_lis_type" {
  type = string
  default = "forward"
}
variable "public_ec2_id" {
  type = string
}

variable "private_ec2_id" {
  type = string
}