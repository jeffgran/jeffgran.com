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

resource "aws_route53_record" "naked" {
  zone_id = aws_route53_zone.jeffgran-com.zone_id
  name = "jeffgran.com."
  type = "A"
  ttl = "300"
  records = ["162.241.226.160"]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.jeffgran-com.zone_id
  name = "www.jeffgran.com."
  type = "CNAME"
  ttl = "300"
  records = ["jeffgran.com"]
}



module "website" {
  source    = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.9.0"
  namespace = "jg"
  stage     = "prod"
  name      = "jeffgran.com"
  hostname  = "www.jeffgran.com"
  region    = "us-west-1"
}

output "domain_name" {
  value = module.website.s3_bucket_domain_name
}
