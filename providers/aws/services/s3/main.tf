//TODO: Change the region with sed on the pipeline
provider "aws" {
  region = "us-east-1"
}

//The key is like this because we alter with SED in the Jenkins Pipeline
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