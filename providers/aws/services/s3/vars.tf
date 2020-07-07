variable "aws_region" {
  default = "us-east-1"
} 

variable "name" {
  description = "The Unique name of Bucket"
  default = "tf-state-test-bucket-bexs"
}

variable "acl" {
  description = "ACL off bucket (https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl)"
  default = "private"
}
