resource "aws_route53_record" "weighted" {
  count   = var.routing_policy == "Weighted" ? 1 : 0
  zone_id = var.zone_id
  name    = var.name
  type    = var.type
  ttl     = var.ttl

  weighted_routing_policy {
    weight = var.weight
  }

  set_identifier = var.identifier
  records        = [var.records]
}

resource "aws_route53_record" "simple" {
  count   = var.routing_policy == "Simple" ? 1 : 0
  zone_id = var.zone_id
  name    = var.name
  type    = var.type
  ttl     = var.ttl
  records = [var.records]
}
