# Second application reusing some of the modules like VPC and Database. It can use the modules by passing the variables to remote git module
module "remote-product-module"{
  source = ""git::ssh://git@/product/product-terraform.git"
  vpc_id =  module.Network.vpc_id
  database_endpoint = module.database.database_endpoint
  ...
}
