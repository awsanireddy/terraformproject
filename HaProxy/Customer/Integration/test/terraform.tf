terraform {
  backend "s3" {
    bucket  = "integration-test-stack"
    key     = "state/test.tfstate"
    region  = "us-east-2"
    profile = "integration"
  }
}
