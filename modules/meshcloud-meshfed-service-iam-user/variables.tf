variable "iam_user_name" {
  type = string
}

variable "meshcloud_account_id" {
  type        = string
  description = "The ID of the meshCloud AWS Account"
}

variable "root_account_id" {
  type        = string
  description = "The ID of the Root Org Account"
}

variable "privileged_external_id" {
  type        = string
  description = "Privileged external ID for the meshfed-service to use"
}

variable "region" {
  type = string
}

variable "aws_sso_instance_arn" {
  type        = string
  description = "ARN of the AWS SSO instance to use"
}

