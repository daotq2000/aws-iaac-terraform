resource "aws_cloudfront_origin_access_identity" "cloudfront_s3" {
  comment = "Cloudfront distribution"
}
resource "aws_cloudfront_distribution" "cloudfront_s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.eks-project-front-end-source.bucket_domain_name
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
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}
resource "aws_cloudfront_distribution" "my_cf_distribution" {
  origin {
    domain_name = aws_lb.alb.dns_name # The DNS name of the ALB
    origin_id   = "myALBOriginID"
    custom_origin_config {
      http_port              = 80  # Your ALB's HTTP port
      https_port             = 443 # Your ALB's HTTPS port
      origin_protocol_policy = "http-only"  # Or "https-only" or "match-viewer", as per your requirements
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled = true

  # Default cache behavior settings go here
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myALBOriginID"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all" # Allows both HTTP and HTTPS
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # The viewer certificate section can be omitted to default to CloudFront's domain (*.cloudfront.net)
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  # Additional configurations for CloudFront...
}