locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "meshcloud_cost_explorer_user_assume_role" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${data.aws_partition.current.partition}:iam::${var.management_account_id}:role/${var.management_account_service_role_name}"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.privileged_external_id]
    }
  }
}

data "aws_iam_policy_document" "workload_identity_federation" {
  count   = var.workload_identity_federation == null ? 0 : 1
  version = "2012-10-17"

  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [var.workload_identity_federation.identity_provider_arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(var.workload_identity_federation.issuer, "https://")}:aud"

      values = [var.workload_identity_federation.audience]
    }

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(var.workload_identity_federation.issuer, "https://")}:sub"

      values = [var.workload_identity_federation.subject]
    }
  }
}
