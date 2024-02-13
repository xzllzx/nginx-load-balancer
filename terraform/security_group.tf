# Security group for ALB
resource "aws_security_group" "lb" {
  name        = var.lb_sg_name
  description = "Allow HTTP on TCP port 80"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "lb_allow_all_egress" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for Public EC2 Instance
resource "aws_security_group" "public_instance" {
  name        = var.public_ec2_sg_name
  description = "Allow SSH on TCP port 22 and HTTP on TCP port 80"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "public_ec2_allow_ssh" {
  security_group_id = aws_security_group.public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "public_ec2_allow_http" {
  security_group_id = aws_security_group.public_instance.id
  referenced_security_group_id = aws_security_group.lb.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "public_ec2_allow_all_egress" {
  security_group_id = aws_security_group.public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}