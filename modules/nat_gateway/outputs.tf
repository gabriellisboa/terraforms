output "id" {
  value = "${aws_nat_gateway.main.id}"
}

output "nat_gateway_private_ip" {
  value = "${aws_nat_gateway.main.private_ip}"
}
