resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "redis-cluster"
  description = "redis replication"
  node_type                     = "cache.t3.micro"
  num_cache_clusters         = 3
  engine                        = "redis"
  engine_version                = "6.0"
  parameter_group_name          = "default.redis6.x"
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids            = [aws_security_group.redis_sg.id]
  auto_minor_version_upgrade    = true
  automatic_failover_enabled    = true
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = true
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}