terraform {
  backend "s3" {
    bucket = "jeffgran-terraform-remote-state"
    key    = "jeffgran.com/state.tfstate"
    region = "us-west-1"
  }
}

locals {
  domain_name = "jeffgran.com"
  namespace   = "jg"
  stage       = "production"
}

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "use1"
}

resource "aws_route53_zone" "jeffgran-com" {
  name = local.domain_name
}

module "website" {
  source         = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.9.0"
  namespace      = local.namespace
  stage          = local.stage
  name           = local.domain_name
  hostname       = local.domain_name
  region         = "us-west-1"
  parent_zone_id = aws_route53_zone.jeffgran-com.zone_id
}

module "www_website" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.9.0"
  namespace                = local.namespace
  stage                    = local.stage
  name                     = "www.${local.domain_name}"
  hostname                 = "www.${local.domain_name}"
  region                   = "us-west-1"
  parent_zone_id           = aws_route53_zone.jeffgran-com.zone_id
  redirect_all_requests_to = local.domain_name
}

module "cert" {
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=tags/0.4.0"
  domain_name                       = local.domain_name
  process_domain_validation_options = true
  subject_alternative_names         = ["*.${local.domain_name}"]
  wait_for_certificate_issued       = true

  providers = {
    aws = aws.use1
  }
}




output "domain_name" {
  value = module.website.s3_bucket_domain_name
}
