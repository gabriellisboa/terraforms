resource "aws_route_table" "main" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "${var.route_cidr_block}"
    gateway_id = "${var.gateway_id}"
  }

  tags = {
    Name = "${var.name}"
  }
}
