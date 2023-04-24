resource "aws_lb_target_group" "target-group" {
  target_type   = var.albg_target_type
  name          = var.albg_name
  protocol      = var.albg_protocol
  port          = var.albg_port
  vpc_id        = var.lb_vpc_id
  health_check {
    protocol            = var.albg_protocol
    path                = var.albg_path
    healthy_threshold   = var.albg_healthy_threshold
    unhealthy_threshold = var.albg_unhealthy_threshold
    timeout             = var.albg_timeout
    interval            = var.albg_timeout
  }
  tags = {
    Name = "${var.albg_name}"
  }
}

resource "aws_lb" "application-lb" {
  name               = var.alb_i_name
  internal           = var.alb_i_interval
  load_balancer_type = var.alb_i_load_balancer_type
  # security_groups = [aws_security_group.web-server.id]
  security_groups    = var.lb_sg
  subnets            = var.lb_subnet
  tags = {
    Name = "${var.alb_i_name}"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  protocol          = var.lb_lis_protocol
  port              = var.lb_lis_port
  default_action {
    type = var.lb_lis_type
    target_group_arn = aws_lb_target_group.target-group.arn
  }
  tags = {
    Name = "${var.alb_i_name}-listener"
  }
}

resource "aws_alb_target_group_attachment" "ec2_attach_pub" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.public_ec2_id
}

resource "aws_alb_target_group_attachment" "ec2_attach_pri" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.private_ec2_id
}