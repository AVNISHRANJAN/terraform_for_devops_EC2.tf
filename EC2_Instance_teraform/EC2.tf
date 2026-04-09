# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "tera_automate-key-pair"
  public_key = file("terra-automate-key.pub")

  lifecycle {
    ignore_changes = [public_key]
  }
}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name_prefix = "tera-auto-server-1"
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

# Ingress - SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Egress - Allow All
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# EC2 Instances
resource "aws_instance" "my_instance" {
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = each.key
  }
}

# INSTANCE STATE CONTROL

resource "aws_ec2_instance_state" "stop_start" {
  for_each = var.instances
  instance_id = aws_instance.my_instance[each.key].id
  state       = "stopped"
}
