namespace = "ui-app"
aws-region = "us-east-1"
aws_profile = "dev"
vpc_cidr_block = "10.10.40.0/24"
availability_zones = ["us-east-1a","us-east-1c","us-east-1e"]
private_cidr_block = ["10.10.40.0/27", "10.10.40.32/27","10.10.40.64/27"]
public_cidr_block = ["10.10.40.96/27", "10.10.40.128/27","10.10.40.160/27"]
tags = {
  product = "Retail"
  component = "cluster"
  environment = "dev"
}

service-name = "ui-cluster-service"
