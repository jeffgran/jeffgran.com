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
