variable "iam_user_name" {
  type = string
}

variable "region" {
  type = string
}

variable "create_new_bucket" {
  type = bool
}

# See aws_cur_report_definition for details on this flag
variable "create_report_connection" {
  type = bool
}

variable "bucket_name" {
  type = string
}

provider "aws" {
  region = var.region
}