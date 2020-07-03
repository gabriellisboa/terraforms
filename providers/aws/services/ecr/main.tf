provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/ecr.tfstate"
    encrypt = true
  }
}


module ecr {
  source = "../../../../modules/ecr/"
  name   = var.name
  region = var.region
  tags   = var.tags
}
