locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "meshfed_automation_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${var.meshcloud_account_id}:user/${var.meshcloud_account_service_user_name}"]
    }
    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.privileged_external_id]
    }
  }
}

data "aws_iam_policy_document" "meshfed_automation" {
  version = "2012-10-17"

  statement {
    sid    = "VisualEditor0"
    effect = "Allow"
    actions = [
      "cloudformation:UpdateStackInstances",
      "cloudformation:DescribeStackSet",
      "cloudformation:ListStackInstances",
      "cloudformation:CreateStackInstances",
      "cloudformation:UpdateStackInstances",
      "lambda:InvokeFunction"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudformation_admin_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudformation.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "cloudformation_stackset_execution" {
  version = "2012-10-17"

  statement {
    sid       = "VisualEditor0"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${data.aws_partition.current.partition}:iam::*:role/AWSCloudFormationStackSetExecutionRole"]
  }
}
