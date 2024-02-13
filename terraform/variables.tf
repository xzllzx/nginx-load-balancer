# Variables
variable "key_name" {
  type        = string
  description = "Name of private key pair."
}

variable "region" {
  type        = string
  description = "AWS region for all resources."

  default = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "project_log_key" {
  type        = string
  description = "S3 prefix to store project logs"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the Load Balancer."
}

variable "load_balancer_log_key" {
  type        = string
  description = "S3 prefix to store Load Balancer logs"
}

variable "alb_target_group_name" {
  type        = string
  description = "Name of the project."
}

variable "lb_sg_name" {
  type        = string
  description = "Name of the Load Balancer's Security Group."
}

variable "public_ec2_sg_name" {
  type        = string
  description = "Name of the public EC2 instances' Security Group."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to use for VPC"
}

variable "subnet_cidr_blocks" {
  type        = object({
    us-east-1a = string
    us-east-1b = string
  })
  description = "CIDR blocks to use for subnets"
}