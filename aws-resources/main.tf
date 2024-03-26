provider "aws" {
  region = "us-east-1" # replace with your AWS region, e.g., "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create subnets for each AZ for the NLB
resource "aws_subnet" "public" {
  count                   = 3 # Creating three subnets for three AZs
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.us-east-1.names[count.index]}"
}

# Create a security group for the bastion host
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  # Allow SSH from your IP - replace with your IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your-ip-address/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a bastion host in the first public subnet
resource "aws_instance" "bastion" {
  ami           = "ami-id" # replace with the AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "your-key-name"
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name = "BastionHost"
  }
}

resource "aws_lb" "nlb" {
  name               = "my-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.public[*].id
}

# ... configure the target groups and listeners as needed ...