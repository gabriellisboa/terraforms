provider "aws" {
  region = module.environment.aws_region
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/asg-app.tfstate"
    encrypt = true
  }
}

//Import the constants
module "environment" {
  source = "../"
}

module "lb_security_group" {
  source  = "../../../../modules/security_group/create_sg"
  sg_name = var.sg_name
  vpc_id  = var.vpc_id
}

module "sg_rules_https" {
  source            = "../../../../modules/security_group/create_sg_rule"
  port              = 443
  protocol          = "TCP"
  ips_sg_list       = var.ips_sg_list
  security_group_id = module.lb_security_group.id
}


module "application_loadbalancer" {
  source          = "../../../../modules/alb/aws_lb"
  name            = var.elb_name
  security_groups = [module.lb_security_group.id]
  subnets         = var.subnets
  internal        = var.internal
  idle_timeout    = var.elb_idle_timeout

  tags = {
    Name        = var.elb_name
    application = var.application
    package     = var.package
    environment = var.environment

  }
}

module "loadbalancer_lister_https" {
  source            = "../../../../modules/alb/aws_lb_listener"
  ssl_certificate   = true
  load_balancer_arn = module.application_loadbalancer.alb_arn
  certificate_arn   = data.aws_acm_certificate.certificate.arn
  target_group_arn  = module.target_group.alb_tg_arn
}

module "target_group" {
  source                = "../../../../modules/alb/aws_lb_target_group"
  name                  = var.asg_name
  port                  = var.target_group_port
  vpc_id                = var.vpc_id
  path                  = var.target_group_health_path
  matcher               = var.target_group_matcher
  health_check_interval = var.health_check_interval
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  health_check_timeout  = var.health_check_timeout
}

module "lc_security_group" {
  source  = "../../../../modules/security_group/create_sg"
  sg_name = var.lc_sg_name
  vpc_id  = var.vpc_id
}

module "lc_sg_rules_http" {
  source                   = "../../../../modules/security_group/create_sg_rule"
  port                     = 80
  protocol                 = "TCP"
  source_security_group_id = module.lb_security_group.id
  security_group_id        = module.lc_security_group.id
}

module "aws_launch_configuration" {
  source          = "../../../../modules/launch_config"
  lc_name         = var.lc_name
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  path_user_data  = "./user_data.sh"
  security_groups = module.lc_security_group.id
  iam_role        = var.iam_role
  key_name        = var.key_name
}

module "aws_autoscaling_group_tg" {
  source                    = "../../../../modules/asg"
  asg_name                  = "${var.asg_name}-tg"
  associate_elb             = "TG"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  lc_name                   = module.aws_launch_configuration.lc_name
  subnets_id                = var.subnets_ids
  target_group_arns         = [module.target_group.alb_tg_arn]
  tag_name                  = var.asg_name
  tag_team                  = "test-team"
}

module "aws_route_53" {
  source         = "../../../../modules/route_53"
  routing_policy = "Simple"
  zone_id        = data.aws_route53_zone.selected.id
  name           = var.dns_name
  type           = "CNAME"
  records        = module.application_loadbalancer.dns_name
}
