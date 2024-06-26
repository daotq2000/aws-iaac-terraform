resource "aws_security_group" "bastion_sg" {
  name        = "bastion_security_group"
  description = "Allow SSH inbound traffic bastion_sg"
  vpc_id      = aws_vpc.vpc-main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0", aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block
    ]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Warning: This allows traffic from any IP which might not be secure.
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }

  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_security_group" "sg_private_eks_node" {
  name = "Security group private eks node"
  vpc_id = aws_vpc.vpc-main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-main.cidr_block,aws_subnet.private-subnet-1a.cidr_block,aws_subnet.private-subnet-1b.cidr_block,aws_subnet.private-subnet-1c.cidr_block,]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  egress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
# Create SG for RDS Cluster
resource "aws_security_group" "postgres_aurora_sg" {
  name   = "security_rds_cluster"
  vpc_id = aws_vpc.vpc-main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [
      aws_vpc.vpc-main.cidr_block, aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block
    ]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_security_group" "redis_sg" {
  name   = "redis_sg"
  vpc_id = aws_vpc.vpc-main.id
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    cidr_blocks = [aws_vpc.vpc-main.cidr_block,aws_subnet.public-subnet-1a.cidr_block,
      aws_subnet.private-subnet-1a.cidr_block,aws_subnet.private-subnet-1b.cidr_block,aws_subnet.private-subnet-1c.cidr_block,]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
}
#Create SG for Application Load Banlancer
resource "aws_security_group" "alb_sg" {
  name   = "application_loadbalancer_sg"
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0",aws_vpc.vpc-main.cidr_block,aws_subnet.public-subnet-1a.cidr_block,
      aws_subnet.private-subnet-1a.cidr_block,aws_subnet.private-subnet-1b.cidr_block,aws_subnet.private-subnet-1c.cidr_block,]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0",aws_vpc.vpc-main.cidr_block,aws_subnet.public-subnet-1a.cidr_block,
      aws_subnet.private-subnet-1a.cidr_block,aws_subnet.private-subnet-1b.cidr_block,aws_subnet.private-subnet-1c.cidr_block,]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 stands for all
    cidr_blocks = ["10.0.0.0/16"]  # This implies all IP addresses
  }
}
