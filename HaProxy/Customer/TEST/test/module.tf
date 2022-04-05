module "EC2ASG" {
  source             = "../../../modules/Compute"
  key_name = var.key_name
  source_ami = var.source_ami
  instance_type = var.instance_type
  standard_tags = var.standard_tags
  haproxylb_ports = var.haproxylb_ports
  networklb_ports = var.networklb_ports
  namespace = var.namespace
  vpc_id = var.vpc_id
  private_subnet_id = var.private_subnet_id
  public_subnet_id = var.public_subnet_id
  public_cidr_blocks = var.public_cidr_blocks
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  key_file_path = var.key_file_path
  ec2lb_arn = var.ec2lb_arn
}
