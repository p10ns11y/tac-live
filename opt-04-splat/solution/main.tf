terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }
  }

  required_version = ">= 1.9.0"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "opt_04" {
  ami           = "ami-0b40807e5dc1afecf"
  instance_type = "t2.micro"

  ebs_block_device {
    device_name = "sda1"
    volume_size = 16
    encrypted   = true
  }

  ebs_block_device {
    device_name = "sda2"
    volume_size = 16
    encrypted   = true
  }

  tags = {
    Name = "Opt-04-Server"
  }
  monitoring = true
  root_block_device {
    encrypted = true
  }
}
