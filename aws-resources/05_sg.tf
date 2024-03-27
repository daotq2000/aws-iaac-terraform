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
}

resource "aws_security_group" "nlb_targets_sg" {
  name        = "nlb_targets_security_group"
  description = "Allow traffic from NLB"
  vpc_id      = aws_vpc.vpc-main.id
  # Add rules according to your specific requirements
}
