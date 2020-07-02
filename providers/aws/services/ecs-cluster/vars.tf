variable "cluster_name" {
  type    = string
  default = "MyFirstCluster"
}

variable "vpc_id" {
  type    = string
  default = "vpc-051aca1a40d915334"
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
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "subnets_id" {
  type    = list(string)
  default = ["subnet-093e1f5422bdc05bd", "subnet-0bcd3181f1fcf6f4c", "subnet-05af5868420a63313"]
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