resource "aws_security_group" "lb" {
  name   = format("%s-load-balancer", var.project_name)
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }
}

resource "aws_security_group_rule" "ingress_80" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  description       = "Traffic port 80"
  security_group_id = aws_security_group.lb.id
  type              = "ingress"
  protocol          = "tcp"
}

resource "aws_security_group_rule" "ingress_443" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  description       = "Traffic port 443"
  security_group_id = aws_security_group.lb.id
  type              = "ingress"
  protocol          = "tcp"
}

## Load Balancer


resource "aws_lb" "main" {
  name               = format("%s-alb", var.project_name)
  internal           = var.lb_internal
  load_balancer_type = var.lb_type

  subnets = [
    data.aws_ssm_parameter.subnet_public_1a.value,
    data.aws_ssm_parameter.subnet_public_1b.value,
    data.aws_ssm_parameter.subnet_public_1c.value
  ]

  security_groups = [
    aws_security_group.lb.id
  ]
  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  protocol          = "HTTP"
  port              = "80"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Projeto ECS"
      status_code  = "200"
    }
  }
}