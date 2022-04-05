terraform {
  backend "s3" {
    bucket  = "tha-mirth-prod-terraform"
    key     = "state/haproxy.tfstate"
    region  = "us-east-1"
    profile = "tha"
  }
}
