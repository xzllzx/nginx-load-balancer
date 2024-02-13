# ALB
resource "aws_lb" "nginx_lb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  depends_on         = [ aws_instance.public_instance ]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = var.load_balancer_log_key
    enabled = true
  }
}

resource "aws_lb_target_group" "alb_target_group" {
    name                = var.alb_target_group_name
    port                = 80
    protocol            = "HTTP"
    vpc_id              = aws_vpc.main.id

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_lb_target_group_attachment" "tg_attachment_test" {
  for_each = aws_instance.public_instance

  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}