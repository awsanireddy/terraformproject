provider "null" {
  version = "~> 3.1"
}

provider "template" {
  version = "~> 2.2"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 3.51"
  profile = var.aws_profile
}
