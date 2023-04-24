/*variable "my_cluster" {
  type = object({
   cluster_id           = string,
   engine               = string,
   node_type            = string,
   num_cache_nodes      = number,
   parameter_group_name = string,
   engine_version       = string,
   port                 = number,
   security_group_ids   = string,
   subnet_group_name    = string,
   az_mode              = string,
  }) 
}*/
variable "redis_cl_cluster_id" {
  type = string
  default = "cluster"
}
variable "redis_cl_engine" {
  type = string
  default = "redis"
}
variable "redis_cl_engine_version" {
  type = string
  default = "3.2.10"
}
variable "redis_cl_node_type" {
  type = string
  default = "cache.m4.large"
}
variable "redis_cl_num_cache_nodes" {
  type = number
  default = 1
}
variable "redis_cl_parameter_group_name" {
  type = string
  default = "default.redis3.2"
}
variable "redis_cl_port" {
  type = number
  default = 6379
}
variable "eks_sg_id" {
  type = list
}

variable "esg_sub_name" {
  type = string
  default = "my-subnet-group-name"
}

variable "esg_sub_ids" {
  type = list
}