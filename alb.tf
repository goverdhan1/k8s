# Data source for existing ALB
data "aws_lb" "existing_alb" {
  count = var.create_new_alb ? 0 : 1
  name  = var.alb_name
}

# Create new ALB only if specified
resource "aws_lb" "alb" {
  count              = var.create_new_alb ? 1 : 0
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.alb_sg_id]
  subnets           = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name        = var.alb_name
    Environment = var.environment
  }
}

# Outputs
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = var.create_new_alb ? aws_lb.alb[0].dns_name : data.aws_lb.existing_alb[0].dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = var.create_new_alb ? aws_lb.alb[0].zone_id : data.aws_lb.existing_alb[0].zone_id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = var.create_new_alb ? aws_lb.alb[0].arn : data.aws_lb.existing_alb[0].arn
}
