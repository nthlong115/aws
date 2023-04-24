resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.redis_cl_cluster_id
  engine               = var.redis_cl_engine
  node_type            = var.redis_cl_node_type
  num_cache_nodes      = var.redis_cl_num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = var.redis_cl_engine_version
  port                 = var.redis_cl_port
  security_group_ids   = var.eks_sg_id
  subnet_group_name    = aws_elasticache_subnet_group.redis_sub.name
  preferred_availability_zones = [ "us-east-1", "us-east-2" ]
  tags = {
    Name = "${var.redis_cl_cluster_id}"
  }
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis3.2"
}

resource "aws_elasticache_subnet_group" "redis_sub" {
  name = var.esg_sub_name
  subnet_ids = var.esg_sub_ids
  tags = {
    Name = "Subnet-group"
  }
}
