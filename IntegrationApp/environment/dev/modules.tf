# Network Module creates subnets and route tables and security groups for load balancer
module "network" {
  source                      = "../../modules/network"
  namespace                 = var.namespace
  aws_region                  = var.aws_region
  aws_profile                 = var.aws_profile
  vpc_cidr_block              = var.vpc_cidr
  private_cidr_block       = var.private_cidr_blocks
  public_cidr_block         = var.public_cidr_blocks
  tags = var.tags
}

# Configs stored in EFS
module "EFS"{
  source              = "../../modules/EFS"
  vpc_cidr_block = var.vpc_cidr_block
  private_cidr_blocks = var.private_cidr_blocks
  private_subnet_ids  = module.Network.aws_subnet_private_ids
  efssg_id            = module.Network.aws_security_group_efs
  vpc_id              = module.Network.vpc_id
  .....
}


# This will create database
module "Database"{
    source = "../../modules/database"
    vpc_id             = module.Network.vpc_id
    rds_subnet_ids = module.Network.aws_subnet_rds_ids
    ....
}

// This gets executed from null_resource
 module "packer_project"{
    source             = "../../modules/Packer"
    ami_name = var.namespace
    vpc_id = module.Network.vpc_id
    subnet_id  = module.Network.aws_subnet_private_ids
    security_group_id = module.Network.aws_security_group_ec2
    namespace = var.namespace
    masterdbsecretid = module.RDS.master-secret_name
    ....
}

# This will create load balancer and auto scaling group and launch configuration and efs_id is passed to mount to the instance
module "compute" {
  source = "../../modules/compute"
  private_subnet_ids = module.Network.aws_subnet_private_ids
  vpc_id = module.Network.vpc_id
  efs_id = module.EFS.efs-id
  elbsg_internal_id = module.Network.aws_security_group_elbsg_internal
  .....
}
