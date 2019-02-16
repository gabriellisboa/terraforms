variable "vpc_id" {
  description = "The id of the vpc you want to create the subnet in"
  default     = "vpc-033114f0e60b33df6"
}

variable "route_cidr_block" {
  description = "The destination cidr on your route table"
  default     = "0.0.0.0/0"
}

variable "gateway_id" {
  description = "The id of the internet_gateway you want to send traffic to"
  default     = "igw-0058fb6c5ee3cbd6b"
}

variable "name" {
  description = "String to be used as tag 'Name' of the internet gateway"
  default     = "gabiroto-out"
}
