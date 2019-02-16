variable "vpc_id" {
  description = "The id of the vpc you want to create the subnet in"
  default     = "vpc-033114f0e60b33df6"
}

variable "name" {
  description = "String to be used as tag 'Name' of the internet gateway"
  default     = "gabiroto"
}
