terraform {
  required_version = ">=1.9.0"
}

resource "aws_subnet" "web_subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
}

resource "aws_instance" "web_server" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.web_subnet.id

  tags = {
    Name = "${var.webserver_name} webserver"
  }
}
