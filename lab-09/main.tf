####################################
## PUT TERRAFORM CLOUD BLOCK HERE!  ##


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }
  }

  cloud {
    organization = "orllycourse"

    workspaces {
      name = "orielly-live-course"
    }
  }

  required_version = ">= 1.9.0"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "eu-north-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

resource "aws_instance" "lab_09" {
  ami           = "ami-0c6da69dd16f45f72"
  instance_type = "t3.micro"

  tags = {
    Name = "Lab-09-Terraform-Cloud"
  }
  monitoring = true
  root_block_device {
    encrypted = true
  }
}
