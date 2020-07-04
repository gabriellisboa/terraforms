provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/ecs-service.tfstate"
    encrypt = true
  }
}

//Import the constants
module "environment" {
  source = "../../"
}

module "application_loadbalancer" {
  source           = "../../../../../modules/alb/aws_lb"
  name             = "ecs-${var.app_name}"
  internal         = var.internal
  security_groups  = var.internal ? var.default_sg : var.public_sg
  subnets = var.internal ? [module.environment.private_subnet_1, module.environment.private_subnet_2, module.environment.private_subnet_3] : [module.environment.public_subnet_1, module.environment.public_subnet_2, module.environment.public_subnet_3]
  tags = {
    Name        = var.app_name
    application = var.application
    package     = var.package
    environment = var.environment

  }
}

module "loadbalancer_lister_rule_https" {
  source            = "../../../../../modules/alb/aws_lb_listener"
  ssl_certificate   = true
  load_balancer_arn = module.application_loadbalancer.alb_arn
  certificate_arn   = data.aws_acm_certificate.aws.arn
  target_group_arn  = module.target_group.alb_tg_arn
}

module "target_group" {
  source  = "../../../../../modules/alb/aws_lb_target_group"
  name    = module.application_loadbalancer.name
  port    = var.target_group_port
  vpc_id  = data.aws_vpc.vpc.id
  path    = var.target_group_health_path
  matcher = var.target_group_matcher
}

module "service_ecs" {
  source                 = "../../../../../modules/ecs/service_with_scaling"
  fargate_compatibilitie = "Ec2"
  name                   = var.app_name
  cluster_id             = data.aws_ecs_cluster.ecs.arn
  task_definition        = module.task_definition.family_ec2
  desired_count          = 1
  launch_type            = "EC2"
  target_group_arn       = module.target_group.alb_tg_arn
  container_name         = var.app_name
  container_port         = 8080
  predefined_metric_type = var.predefined_metric_type
  cluster_name           = var.cluster_name
  max_capacity           = var.max_capacity
  min_capacity           = var.min_capacity
  tags = {
    Name        = var.app_name
    application = var.application
    package     = var.package
    environment = var.environment
  }
}

# module "create_weighted_dns" {
#   source         = "../../../../../modules/route_53"
#   routing_policy = "Weighted"
#   zone_id        = data.aws_route53_zone.selected.id
#   name           = var.app_name
#   type           = "CNAME"
#   weight         = 100
#   identifier     = "ECS"
#   records        = module.application_loadbalancer.dns_name
# }

module "create_simple_dns" {
  source         = "../../../../../modules/route_53"
  routing_policy = "Simple"
  zone_id        = data.aws_route53_zone.selected.id
  name           = var.app_name
  type           = "CNAME"
  records        = module.application_loadbalancer.dns_name
}

//Create Task Definition to Use
module "task_definition" {
  source                 = "../../../../../modules/ecs/task_definition"
  fargate_compatibilitie = "Ec2"
  family                 = var.app_name
  container_definitions  = data.template_file.task.rendered
}

//Template because inside json have variables
data "template_file" "task" {
  template = "${file("./service.json")}"

  vars = {
    app_name = var.app_name
  }
}

data "template_file" "assume_role" {
  template = "${file("./trusted-relationship.json")}"
}
