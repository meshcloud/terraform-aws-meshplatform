variable "region" {
  type = string
}

variable "iam_user_name" {
  type = string
}

variable "root_account_id" {
  type        = string
  description = "Root account ID that has access to linked accounts cost and usage information"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.49.0"
    }
  }
}

provider "aws" {
  region              = var.region
  allowed_account_ids = [var.root_account_id]
}

resource "aws_iam_user" "cost_explorer_api" {
  name = var.iam_user_name
}

resource "aws_iam_access_key" "cost_explorer_api" {
  user = aws_iam_user.cost_explorer_api.name
}

output "aws_iam_keys" {
  value = {
    aws_access_key = aws_iam_access_key.cost_explorer_api.id
    aws_secret_key = aws_iam_access_key.cost_explorer_api.secret
  }
}

data "aws_iam_policy_document" "ce_reader_permissions" {
  statement {
    actions = [
      "ce:GetReservationUtilization",
      "ce:GetDimensionValues",
      "ce:GetCostAndUsage",
      "ce:GetSavingsPlansUtilization",
      "ce:GetReservationCoverage",
      "ce:GetSavingsPlansCoverage",
      "ce:GetSavingsPlansUtilizationDetails"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "org_access_permissions" {
  statement {
    actions = [
      "organizations:ListAccounts"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect    = "Allow"
    resources = [aws_iam_role.role.arn]
  }
}

resource "aws_iam_policy" "ce_read_access" {
  name        = "${aws_iam_user.cost_explorer_api.name}-cost-explorer-read-access"
  description = "This policy includes all permissions needed for metering service to use cost explorer API."
  policy      = data.aws_iam_policy_document.ce_reader_permissions.json
}

resource "aws_iam_policy" "org_access" {
  name        = "${aws_iam_user.cost_explorer_api.name}-org-access"
  description = "This policy allows the '${aws_iam_user.cost_explorer_api.name}' to list all accounts in the organization. This is required CE user makes request per account."
  policy      = data.aws_iam_policy_document.org_access_permissions.json
}

resource "aws_iam_policy" "assume_role" {
  name        = "${aws_iam_user.cost_explorer_api.name}-sts-assume-role"
  description = "This policy allows ${aws_iam_user.cost_explorer_api.name} to assume the IAM Role '${aws_iam_role.role.name}'"
  policy      = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "role" {
  name               = "${aws_iam_user.cost_explorer_api.name}Role"
  description        = "This role is used by ${aws_iam_user.cost_explorer_api.name} to obtain permissions on an org-wide level"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.cost_explorer_api.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "ce_read_access" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ce_read_access.arn
}

resource "aws_iam_role_policy_attachment" "org_access" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.org_access.arn
}

resource "aws_iam_user_policy_attachment" "assume_role" {
  user       = aws_iam_user.cost_explorer_api.name
  policy_arn = aws_iam_policy.assume_role.arn
}
