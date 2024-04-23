locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "cost_explorer_service" {
  version = "2012-10-17"

  statement {
    sid = "CEReaderPermissions"
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

  statement {
    sid    = "OrgManagementAccess2"
    effect = "Allow"
    actions = [
      "organizations:ListAccounts"
    ]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "cost_explorer_service_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${var.meshstack_account_id}:user/${var.meshstack_account_service_user_name}"]
    }

    dynamic "principals" {
      for_each = var.allow_federated_role ? [true] : []

      content {
        type        = "AWS"
        identifiers = ["arn:${data.aws_partition.current.partition}:iam::${var.meshstack_account_id}:role/${var.meshstack_account_service_user_name}IdentityFederation"]
      }
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.privileged_external_id]
    }
  }
}
