provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/s3.tfstate"
    encrypt = true
  }
}

module "aws_s3_bucket" {
  source                  = "../../../../modules/s3"
  bucket = var.name
  acl    = var.acl
  tags = {
    Name        = var.name,
  }  
} 