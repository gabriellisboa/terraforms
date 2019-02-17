variable "eip_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway"
}

variable "subnet_id" {
  description = "The id of the subnet you'll create the nat on"
}

variable "name" {
  description = "String to be used as tag 'Name' of the nat gateway"
}
