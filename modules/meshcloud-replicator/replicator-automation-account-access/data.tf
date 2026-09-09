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

    dynamic "principals" {
      for_each = var.allow_federated_role ? [true] : []

      content {
        type        = "AWS"
        identifiers = ["arn:${data.aws_partition.current.partition}:iam::${var.meshcloud_account_id}:role/${var.meshcloud_account_service_user_name}IdentityFederation"]
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

data "aws_iam_policy_document" "meshfed_automation" {
  version = "2012-10-17"

  statement {
    sid    = "VisualEditor0"
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = ["*"]
  }
}
