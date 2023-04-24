resource "aws_db_instance" "rds_complete" {
  allocated_storage      = var.rds_allocated_storage
  db_name                = var.rds_db_name
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = aws_db_parameter_group.default.name
  skip_final_snapshot    = var.rds_skip_final_snapshot
  storage_type           = var.rds_storage_type
  max_allocated_storage  = var.rds_max_allocated_storage
  network_type           = var.rds_network_type
  vpc_security_group_ids = var.db_vpc_id
  db_subnet_group_name   = var.db_sub_group
  publicly_accessible    = var.rds_publicly_accessible
  availability_zone      = var.rds_availability_zone
  backup_window          = var.rds_backup_window
  enabled_cloudwatch_logs_exports = [ "audit", "error", "general", "slowquery" ]
  tags = {
    Name = "${var.rds_db_name}"
  }
}

resource "aws_db_instance_automated_backups_replication" "rds_back" {
  source_db_instance_arn = aws_db_instance.rds_complete.arn
  retention_period       = 14
}

resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}