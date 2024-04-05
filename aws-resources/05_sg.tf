resource "aws_security_group" "bastion_sg" {
  name        = "bastion_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc-main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}

resource "aws_security_group" "nlb_targets_sg" {
  name        = "nlb_targets_security_group"
  description = "Allow traffic from NLB"
  vpc_id      = aws_vpc.vpc-main.id
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
  # Add rules according to your specific requirements
}
# Create SG for RDS Cluster
resource "aws_security_group" "rds_cluster_sg" {
  name   = "security_rds_cluster"
  vpc_id = aws_vpc.vpc-main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_security_group" "redis_sg" {
  name   = "redis_sg"
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}
#Create SG for Application Load Banlancer
resource "aws_security_group" "alb_sg" {
  name   = "application_loadbalancer_sg"
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}
