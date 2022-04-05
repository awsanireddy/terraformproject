module "EC2ASG" {
  source             = "../../../modules/Compute"
  subnet_id = var.subnet_id
  key_name = var.key_name
  source_ami = var.source_ami
  instance_type = var.instance_type
  standard_tags = var.standard_tags
  haproxylb_ports = var.haproxylb_ports
  customer = var.customer
  vpc_id = var.vpc_id
  nlb_config = var.nlb_config
  ec2lb_arn = var.ec2lb_arn
}
