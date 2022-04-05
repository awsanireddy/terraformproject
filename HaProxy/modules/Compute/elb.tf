
resource "aws_eip" "eip_nlb" {
  tags    = {
    Name  = "${var.namespace}-nlb-ext"
    Env   = "test"
  }
}
resource "aws_lb" "external-nlb" {
  name               = "${var.namespace}-nlb-ext"
  load_balancer_type = "network"
//  subnets  = flatten([var.public_subnet_id])
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  tags = var.standard_tags
  subnet_mapping {
    subnet_id     = var.public_subnet_id
    allocation_id = aws_eip.eip_nlb.id
  }
}

resource "aws_lb_target_group" "nlbtg" {
  for_each = {for route in var.networklb_ports:  route.port => route}
  name     = "${var.namespace}-${each.value.port}"
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = var.vpc_id
  deregistration_delay = "300"
  health_check {
    interval = "30"
    port = 8080
    protocol = "TCP"
    healthy_threshold = "5"
    unhealthy_threshold= "5"
  }
  depends_on = [aws_lb.external-nlb]
}

resource "aws_lb_listener" "listener"{
  for_each = {for route in var.networklb_ports:  route.port =>route}
    port = each.value.port
    protocol = each.value.protocol
    default_action {
        target_group_arn = aws_lb_target_group.nlbtg[each.value.port].arn
        type             = "forward"
      }
      load_balancer_arn = aws_lb.external-nlb.arn
      depends_on = [aws_lb_target_group.nlbtg]
}
