locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "meshcloud_cost_explorer_user_assume_role" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.management_account_id}:role/${var.management_account_service_role_name}"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.privileged_external_id]
    }
  }
}
