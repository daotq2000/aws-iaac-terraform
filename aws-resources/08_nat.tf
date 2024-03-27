resource "aws_eip" "nat-eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-subnet-1a.id
  depends_on = [aws_internet_gateway.gw]
}
