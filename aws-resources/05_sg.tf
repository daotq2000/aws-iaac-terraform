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
    from_port   = 6739
    to_port     = 6739
    protocol    = "tcp"
    cidr_blocks = [
      aws_vpc.vpc-main.cidr_block, aws_subnet.private-subnet-1a.cidr_block, aws_subnet.private-subnet-1b.cidr_block,
      aws_subnet.private-subnet-1c.cidr_block, aws_subnet.public-subnet-1a.cidr_block
    ]
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
}
