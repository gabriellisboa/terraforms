data "aws_vpc" "vpc" {
  tags = {
    Name = "gabiroto"
  }
}

data "aws_acm_certificate" "aws" {
  domain      = "*.gabiroto.ninja"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_ecs_cluster" "ecs" {
  cluster_name = "${var.cluster_name}"
}

data "aws_route53_zone" "selected" {
  name         = "${var.zone_name}"
  private_zone = "${var.internal}"
}
