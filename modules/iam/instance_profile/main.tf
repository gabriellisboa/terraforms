resource "aws_iam_instance_profile" "default" {
  name = var.name
  role = var.role_name
}