variable "cidr_block" {
  description = "The cidr_block your VPC will assume"
}

variable "name" {
  description = "A string to be used as a value to the tag 'Name'"
}

variable "enable_dns_hostnames" {
  description = "Needs to be set to true if your vpc will use private DNS zone"
  default = false
}