provider "aws" {
  version = "~> 2.68"
  region  = module.environment.aws_region
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraforms-gabiroto"
    key     = "tf-states/highly_available_vpc.tfstate"
    encrypt = true
  }
}

//Import the constants
module "environment" {
  source = "../"
}

module "aws_vpc" {
  source     = "../../../../modules/vpc"
  cidr_block = "${var.vpc_cidr_block}"
  name       = "${var.vpc_name}"
}

module "internet_gateway" {
  source = "../../../../modules/internet_gateway"
  vpc_id = "${module.aws_vpc.id}"
  name   = "${var.igw_name}"
}

module "public_subnet_1" {
  source                  = "../../../../modules/subnet"
  vpc_id                  = "${module.aws_vpc.id}"
  cidr_block              = "${var.public_subnet_1_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zone_1}"
  name                    = "${var.public_subnet_1_cidr_block}_${var.availability_zone_1}_public"
}

module "private_subnet_1" {
  source            = "../../../../modules/subnet"
  vpc_id            = "${module.aws_vpc.id}"
  cidr_block        = "${var.private_subnet_1_cidr_block}"
  availability_zone = "${var.availability_zone_1}"
  name              = "${var.private_subnet_1_cidr_block}_${var.availability_zone_1}_private"
}

module "public_subnet_2" {
  source                  = "../../../../modules/subnet"
  vpc_id                  = "${module.aws_vpc.id}"
  cidr_block              = "${var.public_subnet_2_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zone_2}"
  name                    = "${var.public_subnet_2_cidr_block}_${var.availability_zone_2}_public"
}

module "private_subnet_2" {
  source            = "../../../../modules/subnet"
  vpc_id            = "${module.aws_vpc.id}"
  cidr_block        = "${var.private_subnet_2_cidr_block}"
  availability_zone = "${var.availability_zone_2}"
  name              = "${var.private_subnet_2_cidr_block}_${var.availability_zone_2}_private"
}

module "public_subnet_3" {
  source                  = "../../../../modules/subnet"
  vpc_id                  = "${module.aws_vpc.id}"
  cidr_block              = "${var.public_subnet_3_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zone_3}"
  name                    = "${var.public_subnet_3_cidr_block}_${var.availability_zone_3}_public"
}

module "private_subnet_3" {
  source            = "../../../../modules/subnet"
  vpc_id            = "${module.aws_vpc.id}"
  cidr_block        = "${var.private_subnet_3_cidr_block}"
  availability_zone = "${var.availability_zone_3}"
  name              = "${var.private_subnet_3_cidr_block}_${var.availability_zone_3}_private"
}

module "eip_1" {
  source = "../../../../modules/eip"
}

module "eip_2" {
  source = "../../../../modules/eip"
}

module "eip_3" {
  source = "../../../../modules/eip"
}

module "nat_gateway_1" {
  source    = "../../../../modules/nat_gateway"
  eip_id    = "${module.eip_1.id}"
  subnet_id = "${module.public_subnet_1.id}"
  name      = "${var.private_subnet_1_cidr_block}_${var.availability_zone_1}_out"
}

module "public_1_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "IG"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  gateway_id       = "${module.internet_gateway.id}"
  name             = "${var.public_subnet_1_cidr_block}_${var.availability_zone_1}_out"
}

module "private_1_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "NAT"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  nat_gateway_id   = "${module.nat_gateway_1.id}"
  name             = "${var.private_subnet_1_cidr_block}_${var.availability_zone_1}_out"
}

module "nat_gateway_2" {
  source    = "../../../../modules/nat_gateway"
  eip_id    = "${module.eip_2.id}"
  subnet_id = "${module.public_subnet_2.id}"
  name      = "${var.private_subnet_2_cidr_block}_${var.availability_zone_2}_out"
}

module "public_2_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "IG"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  gateway_id       = "${module.internet_gateway.id}"
  name             = "${var.public_subnet_2_cidr_block}_${var.availability_zone_2}_out"
}

module "private_2_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "NAT"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  nat_gateway_id   = "${module.nat_gateway_2.id}"
  name             = "${var.private_subnet_2_cidr_block}_${var.availability_zone_2}_out"
}

module "nat_gateway_3" {
  source    = "../../../../modules/nat_gateway"
  eip_id    = "${module.eip_3.id}"
  subnet_id = "${module.public_subnet_3.id}"
  name      = "${var.private_subnet_3_cidr_block}_${var.availability_zone_3}_out"
}

module "public_3_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "IG"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  gateway_id       = "${module.internet_gateway.id}"
  name             = "${var.public_subnet_3_cidr_block}_${var.availability_zone_3}_out"
}

module "private_3_out_route_table" {
  source           = "../../../../modules/route_table"
  route_destiny    = "NAT"
  vpc_id           = "${module.aws_vpc.id}"
  route_cidr_block = "${var.internet_route_cidr_block}"
  nat_gateway_id   = "${module.nat_gateway_3.id}"
  name             = "${var.private_subnet_3_cidr_block}_${var.availability_zone_3}_out"
}

module "association_private_1" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.private_subnet_1.id}"
  route_table_id = "${module.private_1_out_route_table.route_table_nat_id}"
}

module "association_public_1" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.public_subnet_1.id}"
  route_table_id = "${module.public_1_out_route_table.route_table_ig_id}"
}

module "association_private_2" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.private_subnet_2.id}"
  route_table_id = "${module.private_2_out_route_table.route_table_nat_id}"
}

module "association_public_2" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.public_subnet_2.id}"
  route_table_id = "${module.public_2_out_route_table.route_table_ig_id}"
}

module "association_private_3" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.private_subnet_3.id}"
  route_table_id = "${module.private_3_out_route_table.route_table_nat_id}"
}

module "association_public_3" {
  source         = "../../../../modules/route_table_association"
  subnet_id      = "${module.public_subnet_3.id}"
  route_table_id = "${module.public_3_out_route_table.route_table_ig_id}"
}
