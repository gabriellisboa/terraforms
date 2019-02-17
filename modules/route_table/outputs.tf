output "route_table_ig_id" {
  
  value = "${element(concat(aws_route_table.ig.*.id,  list("")), 0)}"
}

output "route_table_nat_id" {
  value = "${element(concat(aws_route_table.nat.*.id,  list("")), 0)}"
}
