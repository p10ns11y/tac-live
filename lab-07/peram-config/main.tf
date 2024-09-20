provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "webserver-peram" {
  source = "../modules/webserver"
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
  ami = "ami-0c6da69dd16f45f72"
  instance_type = "t3.micro"
  webserver_name = "peram"
}
