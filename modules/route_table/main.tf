resource "aws_route_table" "ig" {
  count             = var.route_destiny == "IG" ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "nat" {
  count             = var.route_destiny == "NAT" ? 1 : 0
  vpc_id = var.vpc_id

  route {
    cidr_block = var.route_cidr_block
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.name}"
  }
}
