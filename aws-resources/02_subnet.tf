resource "aws_subnet" "public-subnet-1a" {
  vpc_id     = aws_vpc.vpc-main.id
  cidr_block = "10.0.0.0/18" # example CIDR block
  availability_zone = "us-east-1a"  # use the availability zone in your region

  map_public_ip_on_launch = true # for the bastion host to be accessible from the internet
  tags = {
    NAME="aws-iaac-terraform"
  }
}
resource "aws_subnet" "private-subnet-1a" {
  vpc_id     = aws_vpc.vpc-main.id
  cidr_block = "10.0.64.0/18" # example CIDR block
  availability_zone = "us-east-1a" # use the availability zone in your region
  tags = {
    NAME="aws-iaac-terraform"
  }
}
resource "aws_subnet" "private-subnet-1b" {
  vpc_id     = aws_vpc.vpc-main.id
  cidr_block = "10.0.128.0/18" # example CIDR block
  availability_zone = "us-east-1b" # use a different availability zone
}
resource "aws_subnet" "private-subnet-1c" {
  vpc_id     = aws_vpc.vpc-main.id
  cidr_block = "10.0.192.0/18" # example CIDR block
  availability_zone = "us-east-1c" # use another different availability zone
}
#Create subnets group for rds cluster
resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.private-subnet-1a.id,aws_subnet.private-subnet-1b.id,aws_subnet.private-subnet-1c.id]
}
# Create subnets group for elastic cache
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis_subnet_group"
  subnet_ids = [aws_subnet.private-subnet-1a.id,aws_subnet.private-subnet-1b.id,aws_subnet.private-subnet-1c.id]
}
