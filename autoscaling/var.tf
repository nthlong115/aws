/*variable "template" {
  type = object({
    name_prefix   = string,
    image_id      = string,
    instance_type = string,
  })
}*/

variable "tp_name_prefix" {
  type = string
  default = "my-teamplate"
}
variable "tp_image_id" {
  type = string
  default = "ami-069aabeee6f53e7bf"
}
variable "tp_instance_type" {
  type = string
  default = "t2.micro"
}
/*variable "asg" {
  type = object({
    capacity_rebalance        = bool,
    desired_capacity          = number,
    max_size                  = number,
    min_size                  = number,
    health_check_grace_period = number,
    health_check_type         = string,
    on_demand_base_capacity                  = number,
    on_demand_percentage_above_base_capacity = number,
    spot_allocation_strategy                 = string,
  })
}*/
variable "asg_capacity_rebalance" {
  type = string
  default = true
}
variable "asg_desired_capacity" {
  type = number
  default = 2
}
variable "asg_max_size" {
  type = number
  default = 4
}
variable "asg_min_size" {
  type = number
  default = 1
}
variable "asg_health_check_grace_period" {
  type = number
  default = 300
}
variable "asg_health_check_type" {
  type = string
  default = "ELB"
}
variable "asg_on_demand_base_capacity" {
  type = number
  default = 1
}
variable "asg_on_demand_percentage_above_base_capacity" {
  type = number
  default = 25
}
variable "asg_spot_allocation_strategy" {
  type = string
  default = "capacity-optimized"
}
variable "asg_vpc_zone" {
  type = list
}

variable "target_group_arn" {
  type = string
}
variable "scal_po_name" {
  type = string
  default = "scalling-policy"
}
variable "warm_up" {
  type = number
  default = 120
}
variable "target_val" {
  type = number
  default = 50
} 