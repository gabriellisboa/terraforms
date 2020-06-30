variable "vpc_id" {
  description = "The id of the vpc you want to create the subnet in"
}

variable "route_cidr_block" {
  description = "The destination cidr on your route table"
}

variable "gateway_id" {
  description = "The id of the internet_gateway you want to send traffic to"
  default     = ""
}

variable "nat_gateway_id" {
  description = "The id of the nat_gateway you want to send traffic to"
  default     = ""
}

variable "name" {
  description = "String to be used as tag 'Name' of the internet gateway"
}

variable "route_destiny" {
  description = "Defines what kind of output your route will point to. NAT or IG"
}
