variable "subnet_id" {
  description = "The id of the subnet you want to associate the route_table_id"
}

variable "route_table_id" {
  description = "Id of the route-table that will be associated to the subnet_id"
}