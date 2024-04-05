resource "aws_rds_cluster" "postgres-cluster" {
  cluster_identifier     = "aurora-postgresql"
  engine_mode            = "provisioned"
  engine_version         = "12.15"
  availability_zones     = var.az
  database_name          = "ecommerce"

  # Database port
  port = 5432

  # VPC settings
  vpc_security_group_ids = [aws_security_group.rds_cluster_sg.id] # Replace with your security group IDs
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name     # Replace with your DB subnet group name

  # Enable deletion protection only for production environments
  deletion_protection = false

  # Serverless V2 specific settings
  serverlessv2_scaling_configuration {
    min_capacity = 0.5 # Specify the minimum capacity units
    max_capacity = 64  # Specify the maximum capacity units
  }

  # Scaling settings
  scaling_configuration {
    auto_pause               = true           # Enable auto-pause
    seconds_until_auto_pause = 300            # Autopause after x seconds of inactivity
    min_capacity             = 1              # Minimum ACUs
    max_capacity             = 2             # Maximum ACUs
  }

}

# If your db instance is not part of an existing cluster
resource "aws_rds_cluster_instance" "postgres-cluster_instances" {
  for_each = var.az
  identifier         = "aurora-cluster-instance-${each.value}"
  cluster_identifier = aws_rds_cluster.postgres-cluster.id
  instance_class     = "db.t3.medium" # Choose the instance class that fits ("db.t3.medium" for serverless)

  engine               = aws_rds_cluster.postgres-cluster.engine
  engine_version       = "11.9"  # Use your target version
  db_subnet_group_name = aws_rds_cluster.postgres-cluster.db_subnet_group_name
}