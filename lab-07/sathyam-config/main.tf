provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "webserver-peram" {
  source = "../modules/webserver"
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
  ami = "ami-0a0e5d9c7acc336f1"
  instance_type = "t3.micro"
  webserver_name = "sathyam"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"
}
