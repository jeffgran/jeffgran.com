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

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.jeffgran-com.zone_id
  name    = "www.jeffgran.com."
  type    = "CNAME"
  ttl = 300
  records = ["jeffgran.com.s3-website.us-west-1.amazonaws.com"]
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

output "domain_name" {
  value = module.website.s3_bucket_domain_name
}
