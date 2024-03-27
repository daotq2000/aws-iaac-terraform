resource "aws_rds_cluster" "postgres-cluster" {
  cluster_identifier      = "postgres-cluster"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "ecommerce"
  master_username         = "postgres"
  master_password         = "nd0nnItGfxKBGDI"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_cluster_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  engine                  = "postgres"
  engine_version          = "11.17"
  depends_on = [
    aws_db_subnet_group.subnet_group,
    aws_security_group.rds_cluster_sg
  ]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 3
  identifier         = "${aws_rds_cluster.postgres-cluster.cluster_identifier}-instance-${count.index}"
  cluster_identifier = "${aws_rds_cluster.postgres-cluster.id}"
  instance_class     = "db.t2.micro"
  engine             = "postgres"
  engine_version     = "11.18"
  publicly_accessible= false
  depends_on = [
    aws_rds_cluster.postgres-cluster
  ]
}


