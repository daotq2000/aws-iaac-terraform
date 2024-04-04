resource "aws_rds_cluster" "postgres-cluster" {
  cluster_identifier     = "aurora-postgresql"
  engine_mode            = "provisioned"
  engine_version         = "12.15"
  availability_zones     = var.az
  database_name          = "ecommerce"
  master_username        = "postgres"
  master_password        = "nd0nnItGfxKBGDI"
  storage_encrypted      = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_cluster_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
  depends_on = [
    aws_db_subnet_group.subnet_group,
    aws_security_group.rds_cluster_sg
  ]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  for_each            = var.az
  identifier          = "${aws_rds_cluster.postgres-cluster.cluster_identifier }-instance-${each.value}"
  availability_zone   = each.value
  cluster_identifier  = "${aws_rds_cluster.postgres-cluster.id}"
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.postgres-cluster.engine
  engine_version      = aws_rds_cluster.postgres-cluster.engine_version
  publicly_accessible = false
  depends_on          = [
    aws_rds_cluster.postgres-cluster
  ]
}


