provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  #alias  = "module-provider"
  version = "~> 2.57.0"
}
