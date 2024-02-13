# Terraform backend
terraform {
  backend "s3" {
    bucket = "nginx-logging-zx"
    key    = "nginx.tfstate"
    region = "us-east-1"
  }
}