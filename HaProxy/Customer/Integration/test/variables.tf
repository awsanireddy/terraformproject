variable "aws_region" {
  description = "The region to run the terraform changes."
}

variable "aws_profile" {
}
variable "key_name" {
}
variable "standard_tags" {
  type = map(string)
 }
variable "haproxylb_ports" {
  type        = list
  description = "list of ingress ports for Mirth External Elastic Load Balancer"
}
variable "source_ami"{}
variable "customer"{}
variable "subnet_id"{}
variable "instance_type"{}
variable "vpc_id"{}

# variables.tf
variable "nlb_config" {
  type = map(string)
}
variable "ec2lb_arn"{}
