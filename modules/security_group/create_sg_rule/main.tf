resource "aws_security_group_rule" "allow_ip" {
  count       = var.source_security_group_id != "" ? 0 : 1
  type        = "ingress"
  from_port   = var.port
  to_port     = var.port
  protocol    = var.protocol
  cidr_blocks = var.ips_sg_list

  security_group_id = var.security_group_id
}

resource "aws_security_group_rule" "allow_sg" {
  count       = var.source_security_group_id != "" ? 1 : 0
  type        = "ingress"
  from_port   = var.port
  to_port     = var.port
  protocol    = var.protocol
  source_security_group_id = var.source_security_group_id

  security_group_id = var.security_group_id
}
