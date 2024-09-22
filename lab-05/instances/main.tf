resource "aws_instance" "lab_05" {
  ami           = "ami-0c6da69dd16f45f72"
  instance_type = "t3.micro"
  key_name      = "aws_key"

  vpc_security_group_ids = [
    aws_security_group.sg_ssh.id,
    aws_security_group.sg_https.id,
    aws_security_group.sg_http.id
  ]

  user_data = file("../scripts/httpd-web-server.yaml")

  tags = {
    Name = "Lab_05-sg_ssh_https"
  }
  root_block_device {
    encrypted = true
  }
  monitoring = true
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuYkU4wU5s3Mg4aasVdJo5pcDAMch9ZlrSfZEpuWLwM peram@PeramanthansMBP"
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


resource "aws_security_group" "sg_http" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}
