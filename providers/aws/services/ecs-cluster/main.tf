provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/asg-app.tfstate"
    encrypt = true
  }
}

module "cluster" {
  source = "../../../../modules/ecs/cluster"
  name   = var.cluster_name
}

module "ecs-instances-sg" {
  source  = "../../../../modules/security_group/create_sg"
  sg_name = var.cluster_name
  vpc_id  = var.vpc_id
}

module "sg_rules_https" {
  source            = "../../../../modules/security_group/create_sg_rule"
  port              = "443"
  protocol          = "TCP"
  ips_sg_list       = var.ips_sg_list
  security_group_id = module.ecs-instances-sg.id
}

module "ecs-instance-role" {
  source             = "../../../../modules/iam/role"
  name               = var.cluster_name
  description        = "Role created for EC2 of ECS cluster ${var.cluster_name}"
  assume_role_policy = var.assume_role_policy
}

module "aws_iam_role_policy_attachment" {
  source     = "../../../../modules/iam/role_policy_attachment"
  role_name  = module.ecs-instance-role.name
  policy_arn = var.policy_arn
}

module "instance_profile" {
  source    = "../../../../modules/iam/instance_profile"
  name      = var.cluster_name
  role_name = module.ecs-instance-role.name
}

module "create-ecs-lc" {
  source          = "../../../../modules/launch_config"
  lc_name         = var.cluster_name
  ami_id          = data.aws_ami.amazon_linux_ecs.id
  instance_type   = var.instance_type
  path_user_data  = "./userdata.sh"
  security_groups = module.ecs-instances-sg.id
  iam_role        = var.cluster_name
  key_name        = var.key_name
}

module "create-ecs-asg" {
  source            = "../../../../modules/asg"
  associate_elb     = "EC2"
  asg_name          = var.cluster_name
  max_size          = var.max_size
  min_size          = var.min_size
  health_check_type = "EC2"
  desired_capacity  = var.desired_capacity
  lc_name           = module.create-ecs-lc.lc_name
  subnets_id        = var.subnets_id
  tag_name          = var.cluster_name
  tag_team          = "test-team"
}