resource "aws_vpc" "vpc-main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    NAME="aws-iaac-terraform"
  }
}