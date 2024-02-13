# Key name
key_name = "nginx-lb"
region = "us-east-1"
project_name = "load-balanced-nginx"

project_log_key = "nginx-logging-zx"

load_balancer_name = "nginx-lb"
load_balancer_log_key = "test-lb"
alb_target_group_name = "WEB-TG"

lb_sg_name = "lb"
public_ec2_sg_name = "public-ec2"

vpc_cidr_block = "192.168.0.0/16"
subnet_cidr_blocks = {
    "us-east-1a" = "192.168.101.0/24"
    "us-east-1b" = "192.168.102.0/24"
    }