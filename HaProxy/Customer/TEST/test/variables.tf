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
variable "namespace"{}
variable "private_subnet_id"{}
variable "public_subnet_id"{}
variable "instance_type"{}
variable "vpc_id"{}

variable "public_cidr_blocks"{
  type = list(string)
}
variable "networklb_ports" {
  type = list
}
variable "enable_cross_zone_load_balancing"{}
variable "key_file_path"{}
variable "ec2lb_arn"{}
