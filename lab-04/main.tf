terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.00"
    }
  }

  required_version = ">=1.9.0"
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "lab_04" {
  ami           = "ami-0c6da69dd16f45f72"
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.sg_ssh.id,
    aws_security_group.sg_https.id
  ]

  tags = {
    Name = "Lab_04-sg_ssh_https"
  }
}

# Although cidr_blocks, ipv6_cidr_blocks, prefix_list_ids,
# and security_groups are all marked as optional,
# you must provide one of them in order to configure the source of the traffic.
resource "aws_security_group" "sg_ssh" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 22
    to_port = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

resource "aws_security_group" "sg_https" {
  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    protocol = "tcp"
    from_port = 443
    to_port = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}
