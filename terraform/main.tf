terraform {
  backend "s3" {
    bucket = "jeffgran-terraform-remote-state"
    key    = "jeffgran.com/state.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_route53_zone" "jeffgran-com" {
  name = "jeffgran.com"
}

module "website" {
  source         = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.9.0"
  namespace      = "jg"
  stage          = "prod"
  name           = "jeffgran.com"
  hostname       = "jeffgran.com"
  region         = "us-west-1"
  parent_zone_id = aws_route53_zone.jeffgran-com.zone_id
}

module "www_website" {
  source         = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.9.0"
  namespace      = "jg"
  stage          = "prod"
  name           = "www.jeffgran.com"
  hostname       = "www.jeffgran.com"
  region         = "us-west-1"
  parent_zone_id = aws_route53_zone.jeffgran-com.zone_id
  redirect_all_requests_to = "jeffgran.com"
}

module "cert" {
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=tags/0.4.0"
  domain_name                       = "jeffgran.com"
  process_domain_validation_options = true
  subject_alternative_names         = ["*.jeffgran.com"]
  wait_for_certificate_issued       = true
}


output "domain_name" {
  value = module.website.s3_bucket_domain_name
}
