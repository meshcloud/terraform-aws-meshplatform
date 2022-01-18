locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "meshfed_service" {
  version = "2012-10-17"
  statement {
    sid       = "StsAccessMemberAccount"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::*:role/${aws_iam_role.meshstack_account_access.name}"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.privileged_external_id]
    }
  }

  statement {
    sid    = "OrgManagementAccess1"
    effect = "Allow"
    actions = [
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribeAccount",
      "organizations:ListParents",
      "organizations:ListOrganizationalUnitsForParent",
      "organizations:CreateOrganizationalUnit",
      "organizations:ListTagsForResource",
      "organizations:TagResource",
      "organizations:UntagResource",
      "organizations:MoveAccount"
    ]
    resources = [
      "arn:aws:organizations::*:account/o-*/*",
      "arn:aws:organizations::*:ou/o-*/ou-*",
      "arn:aws:organizations::${local.account_id}:root/o-*/r-*"
    ]
  }

  statement {
    sid    = "OrgManagementAccess2"
    effect = "Allow"
    actions = [
      "organizations:ListRoots",
      "organizations:ListAccounts",
      "organizations:CreateAccount",
      "organizations:DescribeCreateAccountStatus"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "OrgManagementAccessSSO"
    effect = "Allow"
    actions = [
      "sso:ListAccountAssignments",
      "sso:CreateAccountAssignment",
      "sso:DescribeAccountAssignmentCreationStatus"
    ]
    resources = [
      "${var.aws_sso_instance_arn}",
      "arn:aws:sso:::permissionSet/*/*",
      "arn:aws:sso:::account/*"
    ]
  }

  # Without these additional rights AWS SSO cannot assign groups to the organization's root account.
  # All other accounts can be managed without these additional rights. So if in some environment the
  # root account is not supposed to be managed by meshStack, this statement can be removed.
  statement {
    sid    = "OrgManagementAccessAdditionalSSOForRootAccount"
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:GetSAMLProvider"
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:saml-provider/*",
      "arn:aws:iam::${local.account_id}:role/*"
    ]
  }
}

data "aws_iam_policy_document" "meshfed_service_user_assume_role" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.meshfed_service.arn]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.privileged_external_id]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.meshfed_automation.arn]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.privileged_external_id]
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
      "cloudformation:UpdateStackInstances"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "meshcloud_minimal_service" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateSAMLProvider",
      "iam:GetSAMLProvider",
      "iam:UpdateSAMLProvider",
      "iam:DeleteSAMLProvider",
      "iam:ListSAMLProviders"
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:saml-provider/*",
      "arn:aws:cloudformation:*:${local.account_id}:stack/meshstack-cf-access*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:ListAttachedRolePolicies",
      "iam:CreateAccountAlias",
      "iam:ListAccountAliases",
      "iam:DeleteAccountAlias",
      "iam:GetRole",
      "iam:CreateRole",
      "iam:AttachRolePolicy",
      "iam:UpdateAssumeRolePolicy"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudformation_stackset_execution" {
  version = "2012-10-17"

  statement {
    sid       = "VisualEditor0"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.cloudformation_stackset_admin.arn]
  }
}

data "aws_iam_policy_document" "meshfed_service_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.meshcloud_account_id}:user/${aws_iam_user.meshfed_service.name}"]
    }
    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.privileged_external_id]
    }
  }
}

data "aws_iam_policy_document" "root_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.root_account_id}:root"]
    }
    actions = ["sts:AssumeRole"]
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
