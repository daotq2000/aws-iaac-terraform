resource "aws_lb" "alb" {
  name               = "application-loadbalancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.private-subnet-1a.id,aws_subnet.private-subnet-1b.id,aws_subnet.private-subnet-1c.id,aws_subnet.public-subnet-1a.id]
  enable_deletion_protection = false
}