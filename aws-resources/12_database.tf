resource "aws_rds_cluster" "aurora-postgresql-cluster" {
  cluster_identifier = "aurora-postgresql-cluster"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.7"
  database_name      = "test"
  master_username    = "test"
  master_password    = "sadalkdakl232"
  vpc_security_group_ids = [aws_security_group.rds_cluster_sg.id] # Replace with your security group IDs
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  storage_encrypted  = true
  skip_final_snapshot = true
  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "aurora-postgresql-cluster" {
  for_each = var.az
  identifier = "instance-${each.value}"
  cluster_identifier = aws_rds_cluster.aurora-postgresql-cluster.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora-postgresql-cluster.engine
  engine_version     = aws_rds_cluster.aurora-postgresql-cluster.engine_version
  availability_zone = each.value
}