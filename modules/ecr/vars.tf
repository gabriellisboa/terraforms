variable "name" {
  description = "Repository Name"
}

variable "tags" {
  description = "AWS tags to be used in this resource"
  type = map
}

variable "region" {
  description = "Aws region"
}