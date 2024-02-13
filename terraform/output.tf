# Output
output "load_balancer_dns_name" {
  description = "Public DNS of ALB"
  value = aws_lb.nginx_lb.dns_name
}

output "instance_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = [
    for instance in aws_instance.public_instance : instance.public_dns
  ]
}
