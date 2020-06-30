data "aws_acm_certificate" "certificate" {
  domain      = "*.gabiroto.ninja"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "selected" {
  name         = "${var.zone_name}"
  private_zone = false
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "gabiroto"
  }
}
