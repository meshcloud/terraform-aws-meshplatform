locals {
  account_id = data.aws_caller_identity.current.account_id # current account number.
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "meshfed_service" {
  version = "2012-10-17"
  statement {
    sid       = "StsAccessMemberAccount"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${data.aws_partition.current.partition}:iam::*:role/${var.meshstack_access_role_name}"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.privileged_external_id]
    }
  }

  statement {
    sid    = "OrgManagementAccessRead"
    effect = "Allow"
    actions = [
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribeAccount",
      "organizations:ListParents",
      "organizations:ListOrganizationalUnitsForParent",
      "organizations:ListTagsForResource"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:organizations::*:account/o-*/*",
      "arn:${data.aws_partition.current.partition}:organizations::*:ou/o-*/ou-*",
      "arn:${data.aws_partition.current.partition}:organizations::${local.account_id}:root/o-*/r-*"
    ]
  }

  statement {
    sid    = "OrgManagementAccessWrite"
    effect = "Allow"
    actions = [
      "organizations:TagResource",
      "organizations:UntagResource",
      "organizations:MoveAccount"
    ]
    resources = concat(
      [
        # The actions organizations:TagResource and organizations:UntagResource act on accounts.
        # The actions can not be restricted to a subtree of the OU hierarchy. This is a limitation in the permission model of AWS Organization Service.
        # To supprt tagging for this meshPlatform we need to allow both actions on all accounts.
        "arn:${data.aws_partition.current.partition}:organizations::*:account/o-*/*",
        # New accounts need to be moved from root to the target OU.
        "arn:${data.aws_partition.current.partition}:organizations::${local.account_id}:root/o-*/r-*"
      ],
    var.landing_zone_ou_arns)
  }

  statement {
    sid    = "OrgManagementAccessNoResourceLevelRestrictions"
    effect = "Allow"
    actions = [
      "organizations:ListRoots",
      "organizations:ListAccounts",
      "organizations:CreateAccount",
      "organizations:DescribeCreateAccountStatus"
    ]
    # The actions in this statement do not support resource level retrictions.
    # The actions can not be restricted to a subtree of the OU hierarchy. This is a limitation in the permission model of AWS Organization Service.
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
      "arn:${data.aws_partition.current.partition}:sso:::permissionSet/*/*",
      "arn:${data.aws_partition.current.partition}:sso:::account/*"
    ]
  }

  # Without these additional rights AWS SSO cannot assign groups to the organization's root account.
  # All other accounts can be managed without these additional rights.
  dynamic "statement" {
    for_each = var.support_root_account_via_aws_sso ? [1] : []
    content {
      sid    = "OrgManagementAccessAdditionalSSOForRootAccount"
      effect = "Allow"
      actions = [
        "iam:GetRole",
        "iam:ListAttachedRolePolicies",
        "iam:ListRolePolicies",
        "iam:GetSAMLProvider",
        "iam:CreateRole",
        "iam:AttachRolePolicy",
        "iam:UpdateAssumeRolePolicy"
      ]
      resources = [
        "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:saml-provider/*",
        "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/*"
      ]
    }
  }
}

data "aws_iam_policy_document" "meshfed_service_assume_role" {
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

# As per AWS recommendation https://docs.aws.amazon.com/controltower/latest/userguide/roles-how.html#automated-provisioning
data "aws_iam_policy_document" "meshfed_service_enrollment_additional" {
  version = "2012-10-17"
  statement {
    sid    = "AWSControlTowerAccountFactoryAccess"
    effect = "Allow"
    actions = [
      "sso:GetProfile",
      "sso:CreateProfile",
      "sso:UpdateProfile",
      "sso:AssociateProfile",
      "sso:CreateApplicationInstance",
      "sso:GetSSOStatus",
      "sso:GetTrust",
      "sso:CreateTrust",
      "sso:UpdateTrust",
      "sso:GetPeregrineStatus",
      "sso:GetApplicationInstance",
      "sso:ListDirectoryAssociations",
      "sso:ListPermissionSets",
      "sso:GetPermissionSet",
      "sso:ProvisionApplicationInstanceForAWSAccount",
      "sso:ProvisionApplicationProfileForAWSAccountInstance",
      "sso:ProvisionSAMLProvider",
      "sso:ListProfileAssociations",
      "sso-directory:ListMembersInGroup",
      "sso-directory:AddMemberToGroup",
      "sso-directory:SearchGroups",
      "sso-directory:SearchGroupsWithGroupName",
      "sso-directory:SearchUsers",
      "sso-directory:CreateUser",
      "sso-directory:DescribeGroups",
      "sso-directory:DescribeDirectory",
      "sso-directory:GetUserPoolInfo",
      "controltower:CreateManagedAccount",
      "controltower:DescribeManagedAccount",
      "controltower:DeregisterManagedAccount",
      "s3:GetObject",
      "organizations:describeOrganization",
      "sso:DescribeRegisteredRegions"
    ]
    resources = ["*"]
  }
}
