variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
  default = "eks-vpc"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB and NLB"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet IDs for ASG"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "ghcr_username" {
  description = "GitHub Container Registry username"
  type        = string
  sensitive   = true
  default     = "goverdhansoulverse"
}


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "environment" {
  description = "Name of the Environment to use"
  type        = string
  default     = "dev"
}

variable "root_domain_name" {
  type        = string
  description = "The root domain name for Route53 zone lookup"
  default     = "soulverse.us"
}

variable "domain_name" {
  description = "Domain name for the ALB"
  type        = string
  default     = "eks.soulverse.us"
}

variable "create_route53_zone" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = false
}

variable "create_www_redirect" {
  description = "Whether to create a www CNAME record"
  type        = bool
  default     = true
}

variable "workstation_ips" {
  description = "CIDR blocks of workstation IPs that need cluster access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Warning: This allows access from anywhere. Replace with your IP ranges
}

variable "create_new_nlb" {
  description = "Whether to create a new ALB"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ARN of SSL certificate for HTTPS listener"
  type        = string
}

variable "use_existing_security_groups" {
  description = "Whether to use existing security groups"
  type        = bool
  default     = false
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "application-load-balancer"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

# variable "ami_id" {
#   description = "AMI ID for worker nodes"
#   type        = string
#   # You should replace this with the appropriate AMI ID for your region
#   default     = "ami-0c7217cdde317cfec"  # Amazon EKS-optimized AMI
# }

variable "root_volume_size" {
  description = "Root volume size for worker nodes"
  type        = number
  default     = 20
}

variable "create_route53_records" {
  type        = bool
  default     = false
  description = "Whether to create Route53 records"
}

variable "use_existing_roles" {
  description = "Whether to use existing IAM roles"
  type        = bool
  default     = true
}

variable "existing_alb_sg_id" {
  type        = string
  default     = ""
  description = "ID of existing ALB security group if use_existing_security_groups is true"
}

variable "existing_cluster_sg_id" {
  type        = string
  default     = ""
  description = "ID of existing EKS cluster security group when use_existing_security_groups is true"
}

variable "create_new_alb" {
  type        = bool
  default     = true
  description = "Whether to create a new ALB or use an existing one"
}
variable "namespace" {
  type        = string
  description = "Kubernetes namespace where the secret will be created"
  default     = "default"
}

variable "container_image" {
  type        = string
  description = "Container image for the deployment"
  default     = 8080
}

variable "replica_count" {
  type        = number
  description = "Number of replicas for the deployment"
  default     = 1
}

# Add other variables as needed
variable "container_port" {
  type        = number
  description = "Container port"
  default     = 3000
}

variable "container_env_vars" {
  type        = map(string)
  description = "Environment variables for the container"
  default     = {}
}

variable "health_check_path" {
  type        = string
  description = "Path for health check endpoint"
  default     = "/health"
}

variable "create_new_security_groups" {
  type        = bool
  description = "Whether to create new security groups for the EKS cluster"
  default     = true
}

variable "metrics_server_version" {
  description = "Version of metrics server to install"
  type        = string
  default     = "3.8.2"
}

variable "metrics_server_namespace" {
  description = "Namespace to install metrics server into"
  type        = string
  default     = "kube-system"
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "node_disk_size" {
  type    = number
  default = 50
}



variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
  default     = "0.0.0.0/0" # ⚠ Replace with your IP for better security
}



variable "ami_id" {
  description = "AMI ID for EKS worker nodes (Ubuntu EKS Optimized AMI)"
  type        = string
  default     = "ami-02f9f8af42bef2898"  # Replace with the actual Ubuntu AMI ID for your region
}



variable "ami_owner" {
  description = "Owner ID of the AMI (Default: Canonical for Ubuntu)"
  type        = string
  default     = "099720109477"  # Canonical's AWS Account ID
}

variable "ami_name_pattern" {
  description = "Pattern to filter the latest AMI"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"
}

variable "ami_virtualization_type" {
  description = "Virtualization type of the AMI"
  type        = string
  default     = "hvm"
}
