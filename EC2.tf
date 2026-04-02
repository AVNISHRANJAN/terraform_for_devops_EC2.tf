# Region
provider "aws" {
  region = "us-east-1"
}


# VARIABLE

variable "instance_state" {
  description = "EC2 instance state (running/stopped)"
  type        = string
  default     = "running"
}

# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "tera_automate-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINY/3E+dVZJEQs9HfyGUkTFUwI04CEfYnM+5JqGIa8hL ubuntu@ip-172-31-9-172"
}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name   = "tera-security-group"
  vpc_id = aws_default_vpc.default.id
}

# Ingress - HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Ingress - SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Egress
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# EC2 Instances (3)
resource "aws_instance" "my_instance" {
  count                  = 3
  ami                    = "ami-0c3389a4fa5bddaad"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "tera-auto-server-${count.index}"
  }
}

# INSTANCE STATE CONTROL

resource "aws_ec2_instance_state" "stop_start" {
  count       = 3
  instance_id = aws_instance.my_instance[count.index].id
  state       = var.instance_state
}
