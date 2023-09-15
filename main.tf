terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

resource "aws_vpc" "test" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "test" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.publicCIDR
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "aws_route_table_association" {
  subnet_id      = aws_subnet.test.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "web_ssh" {
  description = "Allow web & ssh"
  vpc_id      = aws_vpc.test.id
  dynamic "ingress" {
    for_each = var.allowed_ports
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = var.instance_AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.test.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  tags = {
    Name = var.instance_tag
  }
  user_data = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo service httpd start
  EOF
}


