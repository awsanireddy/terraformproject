// The following section needs to be updated
// Aws Region where Tenant is set up
aws_region = "us-east-1"
// AWS Profile
aws_profile = "integration"
// EC2 Instance Types and key name for haxproxy
instance_type = "t3.small"
key_name = "integration-haproxy-test"
// Specify Private Subnet ID
subnet_id = ""
// Ubuntu AMI used for HaProxy
source_ami = "ami-039a49e70ea773ffc"
customer = "haproxy-test"
//Standard default Tags for all resources
standard_tags = {
  product = "prod1"
  environment = "test"
}

// Mirth Ports set up for Internal load balancers and security groups
haproxylb_ports = [
    {
      port   = 22
      protocol = "TCP"
      cidr = ""
      description = "AWS Workspaces"
    }
]
vpc_id = ""


# variables.tf
nlb_config = [
    name            = "test-external-nlb"
    internal        = "false"
    environment     = "test"
    subnet          = ""
    nlb_vpc_id      = ""
]

ec2lb_arn = ""
