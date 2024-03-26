resource "aws_vpc" "vpc_AZ1a_iaac" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    NAME = "iaac"
  }
}
resource "aws_subnet" "subnet_AZ1a_iaac" {
  vpc_id = aws_vpc.vpc_AZ1a_iaac.id
  cidr_block = var.vpc_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    NAME ="iaac"
  }

}
resource "aws_internet_gateway" "iwg_AZ1a_iaac" {
  vpc_id = aws_vpc.vpc_AZ1a_iaac.id
  tags = {
    NAME ="iaac"
  }
}
resource "aws_route_table" "route-table-iaac" {
  vpc_id = aws_vpc.vpc_AZ1a_iaac.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iwg_AZ1a_iaac.id
  }
  tags = {
    NAME ="iaac"
  }
}
resource "aws_route_table_association" "route-table-associate-iaac" {
  subnet_id = aws_subnet.subnet_AZ1a_iaac.id
  route_table_id = aws_route_table.route-table-iaac.id
}
