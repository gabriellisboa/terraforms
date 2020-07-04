data "aws_ami" "amazon_linux_ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["gabiroto"]
  }
}

data "aws_subnet" "private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["10.69.1.0/24_us-east-1a_private"]
  }
}

data "aws_subnet" "private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["10.69.2.0/24_us-east-1b_private"]
  }
}

data "aws_subnet" "private_subnet_3" {
  filter {
    name   = "tag:Name"
    values = ["10.69.3.0/24_us-east-1c_private"]
  }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["10.69.4.0/24_us-east-1a_public"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["10.69.5.0/24_us-east-1b_public"]
  }
}

data "aws_subnet" "public_subnet_3" {
  filter {
    name   = "tag:Name"
    values = ["10.69.6.0/24_us-east-1c_public"]
  }
}
