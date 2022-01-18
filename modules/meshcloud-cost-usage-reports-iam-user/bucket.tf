# This is needed in case create_new_bucket is false
data "aws_s3_bucket" "selected" {
  bucket = var.bucket_name

  depends_on = [
    aws_s3_bucket.cost_usage_report
  ]
}

resource "aws_s3_bucket" "cost_usage_report" {
  count  = var.create_new_bucket ? 1 : 0
  bucket = var.bucket_name
  acl    = "private"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.49.0"
    }
  }
}
# This provider is needed, because aws_cur_report_definition atm
# can only exist in the us-east-1 region 
# see https://www.terraform.io/docs/providers/aws/r/cur_report_definition.html
provider "aws" {
  alias  = "cost_report_only"
  region = "us-east-1"
}

# NOTE: if AWS Organizations is enabled only the master account can create this 
# resource, hence the separate switch
resource "aws_cur_report_definition" "cost_usage_report" {
  count                      = var.create_report_connection ? 1 : 0
  report_name                = "aws-cost-usage-report"
  time_unit                  = "DAILY"
  compression                = "GZIP"
  format                     = "textORcsv"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = data.aws_s3_bucket.selected.bucket
  s3_region                  = var.region
  provider                   = aws.cost_report_only
}