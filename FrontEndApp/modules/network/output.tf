output "vpc_id"{
  value = aws_vpc.vpc.id
}

output "http_sg"{
  value = aws_security_group.http.id
}

output "ui-sg"{
  value = aws_security_group.ui.id
}
