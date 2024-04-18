resource "aws_lb" "alb" {
  name               = "application-loadbalancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-subnet-1a.id,aws_subnet.private-subnet-1b.id,aws_subnet.private-subnet-1c.id,]
  enable_deletion_protection = false
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}