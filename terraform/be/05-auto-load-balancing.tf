resource "aws_lb" "public_alb" {
  name = "public-alb"
  internal = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.be.id]

  subnets = [
    "subnet-09f4880d072f09a92",
    "subnet-0a7788d1472394ddc"
  ]

  enable_deletion_protection = false

  tags = {
    Name = "load-balanced-app"
    Environment = "production"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port = 80

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "empty response"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "phonebook_app" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg-ph.arn
  }

  condition {
    host_header {
      values = ["phonebook.com"]
    }
  }
}

resource "aws_lb_target_group" "tg-ph" {
  vpc_id = "vpc-03d43e2e542b53e2e"
  name     = "tg-app"
  port     = 80
  protocol = "HTTP"
}