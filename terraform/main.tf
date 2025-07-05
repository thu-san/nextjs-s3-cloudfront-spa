terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

# Default provider
provider "aws" {}

# Provider for us-east-1 (required for CloudFront ACM certificates)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

module "static_site" {
  source = "git::https://github.com/thu-san/terraform-aws-static-site.git"


  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  s3_bucket_name               = "nextjs-s3-cloudfront-spa-${var.environment}"
  cloudfront_distribution_name = "NextJS SPA Example"

  # Enable custom error responses for SPA routing
  custom_error_responses = [
    {
      error_code            = 403
      response_code         = 200
      response_page_path    = "/404.html"
      error_caching_min_ttl = 0
    },
    {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/404.html"
      error_caching_min_ttl = 0
    }
  ]

  tags = {
    Environment = var.environment
    Framework   = "nextjs"
    Type        = "s3-cloudfront-spa"
  }
}
