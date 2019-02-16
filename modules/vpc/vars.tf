variable "cidr_block" {
  description = "The cidr_block your VPC will assume"
  default     = "10.69.0.0/16"
}

variable "name" {
  description = "A string to be used as a value to the tag 'Name'"
  default     = "gabiroto"
}