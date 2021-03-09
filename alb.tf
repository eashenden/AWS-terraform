
resource "aws_lb" "coalfire-alb" {
  name               = "coalfire-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "coalfire-alb"
  }
}

resource "aws_lb_listener" "coalfire-alb-listener" {
  load_balancer_arn = aws_lb.coalfire-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.coalfire-alb-tg.arn
  }
}

resource "aws_lb_target_group" "coalfire-alb-tg" {
  name        = "coalfire-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.coalfire-vpc.id
  target_type = "instance"

  tags = {
    Name = "coalfire-alb-tg"
  }
}

resource "aws_lb_target_group_attachment" "coalfire-alb-tga" {
  target_group_arn = aws_lb_target_group.coalfire-alb-tg.arn
  target_id        = aws_instance.coalfire-rhel3.id
  port             = 80
}
