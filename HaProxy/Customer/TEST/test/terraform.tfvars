// The following section needs to be updated
// Aws Region where Tenant is set up
aws_region = "us-east-1"
// AWS Profile
aws_profile = "product"
// EC2 Instance Types and key name for haxproxy
instance_type = "t3.small"

// Specify Private Subnet ID
private_subnet_id = ""
// Linux AMI used for HaProxy
source_ami = "ami-0fa397cb3e4668b7a"
namespace = "product-product1-test"
//Standard default Tags for all resources
standard_tags = {
  Name = "product-product1-test-haproxy"
  billing-product = "ENS"
  billing-component = "product1"
  billing-environment = "test"
  Owner = "delivery"
  ParkMyCloud = "easterndefault"
}

networklb_ports = [

    {
      enabled = true
      port   = 10003
      protocol = "TCP"
      cidr = "10.10.10.10/24"
      description = "Test 1"
    }
]

// Ports set up for haproxy instance security groups
haproxylb_ports = [
    {
      port   = 22
      protocol = "TCP"
      cidr = "10.10.10.10/24"
      description = "AWS Workspaces"
    }
]
vpc_id = "vpc-999999"
public_subnet_id = "subnet-999999"
public_cidr_blocks = ["10.10.10.10/27","10.10.10.32/27","10.10.10.64/27"]
enable_cross_zone_load_balancing = "true"
key_file_path = "~/.ssh/product-product1-test.pem"
key_name = "product-product1-test"
ec2lb_arn = "elb"
