provider "aws" {
  region = "us-east-1" # replace with your AWS region, e.g., "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc-iaac" {
  cidr_block = var.vpc_cidr_block
  tags = {
    NAME ="iaac"
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "gw-iaac" {
  vpc_id = aws_vpc.vpc-iaac.id
  tags = {
    NAME ="iaac"
  }
}

# Create subnets for each AZ for the NLB
resource "aws_subnet" "subnet_public-iaac" {
  for_each = var.subnet-az
  vpc_id                  = aws_vpc.vpc-iaac.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = each.key
  tags = {
    NAME ="iaac"
  }
}

# Create a security group for the bastion host
resource "aws_security_group" "bastion_host-iaac" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.vpc-iaac.id

  # Allow SSH from your IP - replace with your IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    NAME ="iaac"
  }
}

# Create a bastion host in the first public subnet
resource "aws_instance" "bastion" {
  ami           = var.ami-bastion-host # replace with the AMI ID for your region
  instance_type = "t2.micro"
  key_name      = var.ssh-key
  subnet_id     = aws_subnet.subnet_public-iaac["us-east-1a"].id
  vpc_security_group_ids = [aws_security_group.bastion_host-iaac.id]

  tags = {
    NAME ="iaac"
  }
}

#resource "aws_lb" "nlb-iaac" {
#  for_each = aws_subnet.subnet_public-iaac
#  name               = "my-nlb"
#  internal           = false
#  load_balancer_type = "network"
#  subnets            = each.id
#  tags = {
#    NAME ="iaac"
#  }
#}

# ... configure the target groups and listeners as needed ...