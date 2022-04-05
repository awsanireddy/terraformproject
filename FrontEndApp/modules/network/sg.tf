# HTTP load balancer traffic
resource "aws_security_group" "http"{
  vpc_id = aws.vpc_id.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [ingress, egress]
  }
}

# HTTP load balancer traffic
resource "aws_security_group" "ui"{
  vpc_id      =aws.vpc_id.id
  ingress {
    from_port   = 6000
    to_port     = 6000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [ingress, egress]
  }
}
