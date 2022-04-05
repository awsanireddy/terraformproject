resource "aws_cloudfront_origin_access_identity" "cloudfront-oai" {
      comment = "${var.namespace}-oai"
}

// Response headers policy
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = "${var.namespace}-security-headers-policy"
  security_headers_config {
    strict_transport_security {
      access_control_max_age_sec = "2592000"
      include_subdomains         = true
      override                   = true
    }
  }
}

resource "aws_cloudfront_distribution" "ui_distribution" {
  //S3 Origin
  origin {
    domain_name = aws_s3_bucket.static-bucket.bucket_regional_domain_name
    origin_id   = local.origin_id_s3
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${var.namespace}-oai"
    }
  }

  //Origin for api
  origin {
    domain_name = var.public_alb_dns
    origin_id   = local.ui-origin-id

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2"]
      origin_read_timeout = 30
      origin_keepalive_timeout = 5
    }
  }
  enabled             = true
  default_root_object = "index.html"

  // All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id       = local.origin_id_s3
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }
  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/ui/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "POST","PATCH","DELETE","PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.ui_origin_id

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = false
    viewer_protocol_policy = "redirect-to-https"
  }


price_class = "PriceClass_100"
viewer_certificate {
  cloudfront_default_certificate = true
}

   restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US","CA"]
    }
  }
}
