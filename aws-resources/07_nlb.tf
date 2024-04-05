
resource "aws_lb" "network_lb" {
  name               = "network-lb"
  load_balancer_type = "network"
  subnets            = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id, aws_subnet.private-subnet-1c.id]
  internal = true
  enable_cross_zone_load_balancing = true

  # Other NLB settings according to your need

  tags = {
    Name = "Network Load Balancer"
  }
}
resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80 # specify your target port
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc-main.id
  # Health check settings, etc.

  # Other settings as per your need
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = "80" # the port NLB listens on
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}