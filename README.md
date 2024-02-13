# Load Balanced Nginx
Load Balanced Nginx server

# Process
### Credentials
1. Generate SSH key to access your VM credentials in AWS IAM console
2. Replace the `key_name` variable in `terraform.tfvars` with your key pair name
3. Configure OpenID Connect to allow GitHub Actions to access resources in your AWS account: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
4. Store the AWS role to assume as `AWS_ROLE_TO_ASSUME` in GitHub Secrets for GitHub Actions: https://github.com/\<*organization*\>/\<*repository*\>/settings/secrets/actions
### Creating and Using Infrastructure
5. Run the GitHub Actions workflow either manually or on push, to create the Terraform stack on AWS
    - You may need to run the workflow twice
6. SSH into EC2 instance with `ssh -i <key-pair-name> ubuntu@<ec2-public-dns>`
7. Perform a GET request to http://\<*load-balancer-public-dns*\>/vend_ip