resource "aws_s3_bucket" "static-bucket" {
  bucket = "${var.namespace}-static-contents"
  policy = "${data.template_file.policy.rendered}"
  tags = {
    Name        = "${var.namespace}-static-contents"
    Environment = "${var.namespace}"
  }
}

resource "aws_s3_bucket_acl" "static-bucket-acl" {
  bucket = aws_s3_bucket.static-bucket.id
}


resource "aws_s3_bucket_public_access_block" "ui-policy" {
  bucket = aws_s3_bucket.static-bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
