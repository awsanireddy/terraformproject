data "template_file" "user_data" {
    template = file("${path.module}/files/startup.tpl")
    vars = {
    ec2lb_arn = var.ec2lb_arn
      }
    }
#Mirth Connect Instance security Group accepts traffic from Internal and External Load balancers and Dynamic ingress rules accept traffic from Network load balancer
resource "aws_security_group" "haproxy" {
    name = "${var.namespace}-haproxy"
    description = "Ha Proxy Instance Security Group"
    vpc_id = var.vpc_id
    dynamic "ingress" {
      for_each = [for s in var.haproxylb_ports: {
        port   = s.port
        protocol = s.protocol
        cidr = s.cidr
        description = s.description
      }]
      content {
        from_port   = ingress.value.port
        to_port  = ingress.value.port
        protocol = ingress.value.protocol
        cidr_blocks = [ingress.value.cidr]
        description = ingress.value.description
    }
  }
  dynamic "ingress" {
    for_each = [for s in var.networklb_ports: {
      port   = s.port
      protocol = s.protocol
      cidr = s.cidr
      description = s.description
    }]
    content {
      from_port   = ingress.value.port
      to_port  = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr]
      description = ingress.value.description
  }
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}


## Create HaProxy Ec2 instance
resource "aws_instance" "haproxylb" {
  vpc_security_group_ids = [aws_security_group.haproxy.id]
  instance_type=var.instance_type
  ami = var.source_ami
  user_data = data.template_file.user_data.rendered
  key_name = var.key_name
  subnet_id = var.private_subnet_id
  depends_on = [aws_security_group.haproxy]
  tags = var.standard_tags
  lifecycle {
    create_before_destroy = true
  }

