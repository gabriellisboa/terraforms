variable "vpc_id" {
  description = "The id of the vpc you want to create the subnet in"
  default     = "vpc-033114f0e60b33df6"
}

variable "cidr_block" {
  description = "The cidr your subnet will assume"
  default     = "10.69.1.0/24"
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
  default     = false
}

variable "availability_zone" {
  description = "The name of the availability zone you want your subnet in it"
  default     = "us-east-1a"
}

variable "name" {
  description = "String to be used as tag 'Name' of the subnet"
  default = "10.69.1.0/24 us-east-1a private"
}
