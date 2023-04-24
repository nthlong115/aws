/*variable "rds" {
  type = object({
    allocated_storage      = number,
    db_name                = string,
    engine                 = string,
    engine_version         = string,
    instance_class         = string,
    username               = string,
    password               = string,
    skip_final_snapshot    = bool,
    storage_type           = string,
    max_allocated_storage  = number,
    network_type           = string,
    publicly_accessible    = bool,
    availability_zone      = string,
    backup_window          = string,
  })
}*/
variable "rds_allocated_storage" {
  type = number
  default = 10
}
variable "rds_db_name" {
  type = string
  default = "mydb"
}
variable "rds_engine" {
  type = string
  default = "mysql"
}
variable "rds_engine_version" {
  type = string
  default = "5.7.33"
}
variable "rds_instance_class" {
  type = string
  default = "db.t3.micro"
}
variable "rds_username" {
  type = string
  default = "admin"
}
variable "rds_password" {
  type = string
  default = "admin"
}
variable "rds_skip_final_snapshot" {
  type = bool   
  default = true
}
variable "rds_storage_type" {
  type = string
  default = "gp2"
}
variable "rds_max_allocated_storage" {
  type = number
  default = 1
}
variable "rds_network_type" {
  type = string
  default = "IPV4"
}
variable "rds_publicly_accessible" {
  type = bool
  default = false
}
variable "rds_availability_zone" {
  type = string
  default = "us-east-1"
}
variable "rds_backup_window" {
  type = string
  default = "08:00-09:00"
}
variable "db_vpc_id" {
  type = list
}
variable "db_sub_group" {
  type = string
}