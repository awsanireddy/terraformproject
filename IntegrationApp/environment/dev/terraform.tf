# This file configures remote state storage in an s3 backend
# Only one backend may be specified and the configuration may not contain interpolations. Terraform will validate this.
terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    bucket         = "<bucket-name>"
    key            = "<tfstatename>"
    kms_key_id     = "alias/aws/s3"
    region         = "us-east-1"
    dynamodb_table = "<dbname>"
    profile        = "dev"
  }
}
