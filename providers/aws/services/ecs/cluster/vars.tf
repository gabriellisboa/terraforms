variable "cluster_name" {
  type    = string
  default = "default-cluster"
}

variable "ips_sg_list" {
  type    = list(string)
  default = ["10.69.0.0/16"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "gabiroto-2020-06-29"
}

variable "max_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 3
}

variable "desired_capacity" {
  type    = number
  default = 3
}

variable "assume_role_policy" {
  type    = string
  default = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}