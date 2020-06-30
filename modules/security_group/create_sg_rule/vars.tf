variable "port" {}

variable "protocol" {
  default = "tcp"
}

variable "ips_sg_list" {
  type = list
  default = []
}

variable "source_security_group_id" {
  type = string
  default = ""
}

variable "security_group_id" {}
