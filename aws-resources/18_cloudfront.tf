resource "aws_cloudfront_origin_access_identity" "cloudfront_s3" {
  comment = "Cloudfront distribution"
}
resource "aws_cloudfront_distribution" "cloudfront_s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.eks-project-front-end-source.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.eks-project-front-end-source.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_s3.cloudfront_access_identity_path
    }
  }
  origin {
    domain_name = aws_lb.alb.dns_name
    origin_id   = aws_lb.alb.id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  enabled             = true
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.eks-project-front-end-source.id
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  web_acl_id = aws_wafv2_web_acl_association.WafWebAclAssociation.id
}
