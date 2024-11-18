resource "aws_ssm_parameter" "lb_arn" {
  name  = format("/%s/ecs/alb_arn", var.project_name)
  type  = "String"
  value = aws_lb.main.arn
}

resource "aws_ssm_parameter" "lb_listener" {
  name  = format("/%s/ecs/alb_listener", var.project_name)
  type  = "String"
  value = aws_lb_listener.main.arn
}