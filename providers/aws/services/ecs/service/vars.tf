variable "target_group_port_blue" {
  default     = 8080
  description = "Port of the target group, to receive the traffic form ALB"
}

variable "target_group_health_path_blue" {
  default     = "health"
  description = "Healthcheck path for the TG make in your application"
}

variable "target_group_matcher_blue" {
  default = "200"
}

variable "cluster_name" {
  description = "The name of the cluster to create the service in"
  default = "default-cluster"
}

variable "zone_name" {
  default = "gabiroto.ninja."
}

variable "predefined_metric_type" {
  default = "ECSServiceAverageCPUUtilization"
}

variable "max_capacity" {
  default = 5
}

variable "min_capacity" {
  default = 1
}

variable "desired_count" {
  default = 3
}

variable "internal" {
  default = false
}

variable "default_sg" {
  default     = ["sg-056eaeacb515bbf1e"]
  description = "Default SG for ALB"
}

variable "public_sg" {
  default     = ["sg-02b54df2e1104fc1a"]
  description = "Default SG for ALB"
}

#AWS Tags
variable "app_name" {
  description = "Name of application, and value of tag name"
  default = "test-service"
}

variable "application" {
  description = "Name of application or application who consumes me"
  default = "test-service"
}

variable "package" {
  description = "Name of the business package this application belongs to"
  default = "Devops"
}

variable "environment" {
  description = "Where my environment is prd/stg"
  default = "prod"
}

variable "target_group_port" {
  description = "Port in which your application is listening"
  default = 8080
}

variable "target_group_health_path" {
  description = "Path in which your application is listening"
  default = "health"
}

variable "target_group_matcher" {
  description = "Status code your health check will return when healthy"
  default = 200
}