# data "aws_lb_target_group" "existing_nlb_tg" {
#   name = "nlb-target-group"
# }


# Create NLB target group only if it doesn't exist
resource "aws_lb_target_group" "nlb_tg" {
#   count    = can(data.aws_lb_target_group.existing_nlb_tg.arn) ? 0 : 1
  name     = "nlb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
}
