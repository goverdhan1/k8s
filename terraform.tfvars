environment     = "dev"
vpc_cidr        = "10.0.0.0/16"
aws_region      = "ap-south-1"
cluster_name    = "my-eks-cluster"
vpc_id          = "vpc-08761bc912283491a"
# subnet_ids  = ["subnet-06f7ca5bfbb7f69a7", "subnet-0dce6202cc9e88af5", "subnet-085949d941689adc7"]
subnet_ids  = ["subnet-08d7cbc65bfb4c9de", "subnet-0b5efc0661463aa4a", "subnet-0bd3cb2b82ba42977"]
workstation_ips  = ["183.82.238.234/32"]  # Replace with your IP address
# workstation_ips = ["${chomp(data.http.myip.response_body)}/32"]
create_new_alb   = true  # Set to true if you want to create a new ALB
certificate_arn  = "arn:aws:acm:region:account:certificate/certificate-id"  # Replace with your certificate ARN
root_domain_name = "soulverse.us"
domain_name     = "soulverse.us"  # Replace with your domain
create_route53_zone = false          # Set to true if you want to create a new zone
create_www_redirect = true           # Set to false if you don't want www CNAME
create_new_security_groups = false  # Set to true only if you need new security groups
alb_name                  = "eks-alb"
kubernetes_version = "1.31"
instance_type     = "t3.medium"
root_volume_size  = 20
# Make sure to use the correct AMI ID for your region
ami_id            = "ami-0292e341eaab735ad"
use_existing_roles          = true
use_existing_security_groups = false
existing_alb_sg_id          = ""      # Only needed if use_existing_security_groups = true
existing_cluster_sg_id   = ""  # Only needed if use_existing_security_groups = true
create_route53_records = true
namespace      = "default"    # The namespace where you want to create the secret
ghcr_username  = "goverdhansoulverse"
ghcr_token     = "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"
replica_count     = 1
container_port    = 3000      # adjust to your application's port
health_check_path = "/health" # adjust to your application's health check endpoint
container_image = "ghcr.io/soulverse-ecosystem/connection:latest"
container_env_vars = {
  "PORT" = "3000"
}


ami_owner = "099720109477"  # Canonical (Default)
ami_name_pattern = "ubuntu/images/hvm-ssd/ubuntu-20.04-amd64-server-*"
ami_virtualization_type = "hvm"
