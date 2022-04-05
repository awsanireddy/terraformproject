variable "private_subnet_id"{}
variable "public_subnet_id"{}
variable "standard_tags"{
  type = map(string)
}
variable "haproxylb_ports" {
  type = list
}
variable "networklb_ports" {
  type = list
}
variable "instance_type"{}
variable "key_name"{}
variable "namespace"{}
variable "source_ami"{}
variable "vpc_id"{}
variable "public_cidr_blocks"{
  type = list(string)
}
variable "enable_cross_zone_load_balancing"{}
variable "key_file_path"{}
variable "ec2lb_arn"{}
