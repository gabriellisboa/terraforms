variable "eip_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway"
  default     = "eipalloc-06c6c47fa6aa2b4d4"
}

variable "subnet_id" {
  description = "The id of the subnet you'll create the nat on"
  default     = "subnet-03b4e511450ce7418"
}

variable "name" {
  description = "String to be used as tag 'Name' of the nat gateway"
  default     = "gabiroto-nat"
}
