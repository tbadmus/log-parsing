terraform {
  backend "s3" {
    region = "us-east-1"
  }
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

module "logging" {
  source                     = "github.com/GSA/grace-logging?ref=v0.0.5"
  access_logging_bucket_name = "grace-${var.appenv}-access-logs"
  logging_bucket_name        = "grace-${var.appenv}-logging"
}