
resource "aws_alb" "product_ui_external_lb" {
  name            = "${var.namespace}-ui-external"
  internal        = false
  load_balancer_type = "application"
  security_groups = var.security_group_id
  subnets         = ["${var.public_subnet_id_list}"]
  idle_timeout =   120
}

resource "aws_alb_target_group" "ui-tg"{
  name = "${var.namespace}-ui-external-tg"
  port = "6000"
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id
}

resource "aws_alb_listener" "ui-listener"{
  load_balancer_arn = aws_alb.product_ui_external_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ui-tg.arn
    type             = "forward"
  }

}
