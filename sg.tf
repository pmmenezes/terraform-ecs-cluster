resource "aws_security_group" "main" {
  name   = format("%s", var.project_name)
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

resource "aws_security_group_rule" "snet_ranges" {
  cidr_blocks       = [data.aws_ssm_parameter.vpc_cidr.value]
  from_port         = 0
  to_port           = 0
  description       = "Traffic inernal"
  security_group_id = aws_security_group.main.id
  protocol          = "-1"
  type              = "ingress"

}
