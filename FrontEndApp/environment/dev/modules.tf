# UI for application with CF distribution and S3 bucket which hosts website

module "network"{
    source = "../../modules/network"
    namespace = var.namespace
    aws_region                  = var.aws_region
    aws_profile                 = var.aws_profile
    vpc_cidr_block              = var.vpc_cidr
    private_cidr_block       = var.private_cidr_blocks
    public_cidr_block         = var.public_cidr_blocks
    tags = var.tags
}

module "alb" {
  source = "../../modules/alb"
  namespace = var.namespace
   public_subnet_id_list       = ["${module.network.public_subnet_id_list}"]
   private_subnet_id_list =    ["${module.network.private_subnet_id_list}"]
   vpc_id = module.network.vpc_id
   security_group_id = module.network.http-sg
}

#This will create ecs cluster and ecr repo
module "ecs" {
   namespace = var.namespace
   service_name = var.service_name
   private_subnet_id_list =    ["${module.network.private_subnet_id_list}"]
   security_group_id_1 = module.network.ui-sg
   task_cpu = 256
   task_memory = 1024
}

#This will create a S3 bucket and CF Distribution
module "ui" {
    namespace = var.namespace
    public_alb_dns = module.alb.public_alb_dns
}
