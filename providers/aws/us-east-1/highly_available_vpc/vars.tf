variable "vpc_cidr_block" {
  default = "10.69.0.0/16"
}

variable "vpc_name" {
  default = "gabiroto"
}

variable "public_subnet_1_cidr_block" {
  default = "10.69.4.0/24"
}

variable "private_subnet_1_cidr_block" {
  default = "10.69.1.0/24"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "public_subnet_2_cidr_block" {
  default = "10.69.5.0/24"
}

variable "private_subnet_2_cidr_block" {
  default = "10.69.2.0/24"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}

variable "public_subnet_3_cidr_block" {
  default = "10.69.6.0/24"
}

variable "private_subnet_3_cidr_block" {
  default = "10.69.3.0/24"
}

variable "availability_zone_3" {
  default = "us-east-1c"
}

variable "igw_name" {
  default = "gabiroto"
}

variable "internet_route_cidr_block" {
  default = "0.0.0.0/0"
}
