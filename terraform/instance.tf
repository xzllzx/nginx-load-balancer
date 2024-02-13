# AMI
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = ["ubuntu/images/*22.04*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  most_recent = true
  owners      = ["099720109477"]
}

resource "aws_instance" "public_instance" {
  for_each = aws_subnet.public_subnets

  instance_type               = "t2.micro"
  ami                         = data.aws_ami.amazon_ami.id
  key_name                    = var.key_name
  subnet_id                   = each.value.id
  vpc_security_group_ids      = [aws_security_group.public_instance.id]
  associate_public_ip_address = true
  depends_on                  = [ aws_subnet.public_subnets ]

  user_data                   = file("../userdata.tpl")
}