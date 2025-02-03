# First check if listeners exist
data "aws_lb_listener" "existing_http" {
  count             = var.create_new_alb ? 0 : 1
  load_balancer_arn = data.aws_lb.existing_alb[0].arn
  port              = 80
}


locals {
  create_http_listener  = var.create_new_alb ? true : (try(data.aws_lb_listener.existing_http[0].arn, "") == "")
}

resource "aws_lb_listener" "http" {
  count             = var.create_new_alb ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create listeners for existing ALB only if they don't exist
resource "aws_lb_listener" "existing_http" {
  count             = (var.create_new_alb || !local.create_http_listener) ? 0 : 1
  load_balancer_arn = data.aws_lb.existing_alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}


# Outputs
output "http_listener_arn" {
  description = "ARN of HTTP listener"
  value = try(
    var.create_new_alb ? aws_lb_listener.http[0].arn : (
      local.create_http_listener ? aws_lb_listener.existing_http[0].arn : data.aws_lb_listener.existing_http[0].arn
    ),
    null
  )
}
