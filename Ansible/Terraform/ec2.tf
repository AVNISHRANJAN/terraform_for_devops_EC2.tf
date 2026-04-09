# VARIABLE

variable "instance_state" {
  description = "EC2 instance state (running/stopped)"
  type        = string
  default     = "running"
}

# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "tera_automate-key-pair"
  public_key = file("terra-automate-key.pub")
}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name_prefix = "tera-security-group-"
  vpc_id      = aws_default_vpc.default.id
}

# Ingress - HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Ingress - SSH zaroori hai
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
  for_each = var.instances # 4 instances defined in variable.tf
  //  count                  = 3
  ami                    = "each.value.ami" #iterate through the map to get the AMI for each instance
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = each.key
  }
}

# INSTANCE STATE CONTROL

resource "aws_ec2_instance_state" "stop_start" {
  for_each = aws_instance.my_instance

  instance_id = each.value.id
  state       = "stopped"
}
