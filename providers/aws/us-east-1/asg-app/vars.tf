variable "elb_name" {
  default = "app-name-lb"
}

variable "subnets_ids" {
  default = ["subnet-0adc37309d868ab10", "subnet-0f8a3a9b61a753726", "subnet-092db0e5b766358c2"]
}

variable "elb_idle_timeout" {
  default = 120
}

variable "asg_name" {
  default = "app-name"
}

variable "asg_max_size" {
  default = 1
}

variable "asg_min_size" {
  default = 1
}

variable "asg_health_check_grace_period" {
  default = 120
}

variable "health_check_type" {
  default = true
}

variable "desired_capacity" {
  default = 1
}

variable "lc_name" {
  default = "app-name-lc-"
}

variable "ami_id" {
  default = "ami-09d95fab7fff3776c"
}

variable "instance_type" {
  default = "t2.medium"
}
variable "vpc_id" {
  default = "vpc-07a432eec5f524fcc"
}

variable "iam_role" {
  default = ""
}

variable "key_name" {
  default = "gabiroto-2020-06-29"
}

variable "sg_name" {
  default = "lb-app-name-sg"
}

variable "lc_sg_name" {
  default = "app-name"
}

variable "ips_sg_list" {
  default = ["0.0.0.0/0"]
}

variable "zone_name" {
  default = "gabiroto.ninja."
}

variable "dns_name" {
  default = "app-name"
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 120
}

variable "target_group_port" {
  default = 80
}

variable "target_group_health_path" {
  default = ""
}

variable "target_group_matcher" {
  default = 200
}

variable "health_check_interval" {
  default = 5
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "health_check_timeout" {
  default = 3
}

variable "subnets" {
  type    = list
  default = ["subnet-0adc37309d868ab10", "subnet-0f8a3a9b61a753726", "subnet-092db0e5b766358c2"]
}

variable "internal" {
  default = "false"
}

variable "application" {
  default = "app-name_application"
}
variable "package" {
  default = "devops"
}
variable "environment" {
  default = "prd"
}