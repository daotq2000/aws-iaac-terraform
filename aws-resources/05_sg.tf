resource "aws_security_group" "bastion_sg" {
  name        = "bastion_security_group"
  description = "Allow SSH inbound traffic"
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

  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_security_group" "sg_private_eks_node" {
  vpc_id = aws_vpc.vpc-main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-main.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc-main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group" "nlb_targets_sg" {
  name        = "nlb_targets_security_group"
  description = "Allow traffic from NLB"
  vpc_id      = aws_vpc.vpc-main.id
  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
  # Add rules according to your specific requirements
}
# Create SG for RDS Cluster
resource "aws_security_group" "rds_cluster_sg" {
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
  tags = {
    name        = "terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_security_group" "redis_sg" {
  name   = "redis_sg"
  vpc_id = aws_vpc.vpc-main.id
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
}
