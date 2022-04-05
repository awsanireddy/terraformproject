data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
# Subnets group used by the database
resource "aws_db_subnet_group" "subnetgroup" {

}
# Parameters which can be applied to the database
resource "aws_db_parameter_group" "mirth-pg" {

}
# DB instance creation
resource "aws_db_instance" "mirth-rds" {

}
