variable "vpc_id" {
  description = "The id of the vpc you want to create the subnet in"
}

variable "cidr_block" {
  description = "The cidr your subnet will assume"
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
  default     = false
}

variable "availability_zone" {
  description = "The name of the availability zone you want your subnet in it"
}

variable "name" {
  description = "String to be used as tag 'Name' of the subnet"
}
