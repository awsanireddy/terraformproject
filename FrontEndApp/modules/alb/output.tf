output "public_alb_arn" {
  value = "${aws_alb.product_ui_external_lb.arn}"
}

output "public_alb_dns" {
  value = "${aws_alb.product_ui_external_lb.dns_name}"
}
