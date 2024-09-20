terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }
  }

  required_version = ">=1.9.0"
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c6da69dd16f45f72"
  instance_type = "t3.micro"

  tags = {
    Name = "Lab-03-AWS-Instance"
  }
}
