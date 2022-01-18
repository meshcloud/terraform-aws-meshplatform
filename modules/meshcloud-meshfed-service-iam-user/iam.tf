# AWS Root Account Setup

resource "aws_iam_role" "meshfed_service" {
  name               = "${var.iam_user_name}Role"
  description        = "This role is used by ${aws_iam_user.meshfed_service.name} to obtain permissions on an org-wide level"
  assume_role_policy = data.aws_iam_policy_document.meshfed_service_assume_role.json
}

resource "aws_iam_policy" "meshfed_service" {
  name   = "${aws_iam_user.meshfed_service.name}Policy"
  policy = data.aws_iam_policy_document.meshfed_service.json
}

resource "aws_iam_policy" "meshfed_service_user" {
  provider = aws.meshcloud
  name     = "${aws_iam_user.meshfed_service.name}AssumeRolePolicy"
  policy   = data.aws_iam_policy_document.meshfed_service_user_assume_role.json
}

resource "aws_iam_role_policy_attachment" "meshfed_service" {
  role       = aws_iam_role.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service.arn
}

resource "aws_iam_user_policy_attachment" "meshfed_service" {
  provider   = aws.meshcloud
  user       = aws_iam_user.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service_user.arn
}

# meshStack Account Setup

resource "aws_iam_user" "meshfed_service" {
  provider = aws.meshcloud
  name     = var.iam_user_name
}

resource "aws_iam_access_key" "meshfed_service" {
  provider = aws.meshcloud
  user     = aws_iam_user.meshfed_service.name
}

resource "aws_iam_role" "meshstack_account_access" {
  provider           = aws.meshcloud
  name               = "MeshstackAccountAccessRole"
  description        = "This role is used to provide root account admin access in meshcloud account"
  assume_role_policy = data.aws_iam_policy_document.root_assume_role.json
}

resource "aws_iam_role_policy_attachment" "meshstack_account_access" {
  provider   = aws.meshcloud
  role       = aws_iam_role.meshstack_account_access.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Account Access

resource "aws_iam_policy" "meshcloud_minimal_service" {
  provider = aws.meshcloud
  name     = "${aws_iam_user.meshfed_service.name}-MeshcloudMinimalServicePolicy"
  policy   = data.aws_iam_policy_document.meshcloud_minimal_service.json
}

resource "aws_iam_role_policy_attachment" "meshcloud_minimal_service" {
  provider   = aws.meshcloud
  role       = aws_iam_role.meshstack_account_access.name
  policy_arn = aws_iam_policy.meshcloud_minimal_service.arn
}

# Automation Account Setup

resource "aws_iam_role" "meshfed_automation" {
  name               = "${aws_iam_user.meshfed_service.name}AutomationRole"
  description        = "This role is assumed by ${aws_iam_user.meshfed_service.name} to execute certain CloudFormation setup steps"
  assume_role_policy = data.aws_iam_policy_document.meshfed_service_assume_role.json
}

resource "aws_iam_policy" "meshfed_automation" {
  name   = "${aws_iam_user.meshfed_service.name}AutomationPolicy"
  policy = data.aws_iam_policy_document.meshfed_automation.json
}

resource "aws_iam_role_policy_attachment" "meshfed_automation" {
  role       = aws_iam_role.meshfed_automation.name
  policy_arn = aws_iam_policy.meshfed_automation.arn
}

resource "aws_iam_role" "cloudformation_stackset_admin" {
  name               = "${aws_iam_user.meshfed_service.name}-AWSCloudFormationStackSetAdministrationRole"
  description        = ""
  assume_role_policy = data.aws_iam_policy_document.cloudformation_admin_assume_role.json
}

resource "aws_iam_policy" "cloudformation_stackset_execution" {
  name   = "${aws_iam_user.meshfed_service.name}-AWSCloudFormationStackSetExecutionRole"
  policy = data.aws_iam_policy_document.cloudformation_stackset_execution.json
}

resource "aws_iam_role_policy_attachment" "cloudformation_stackset" {
  role       = aws_iam_role.cloudformation_stackset_admin.name
  policy_arn = aws_iam_policy.cloudformation_stackset_execution.arn
}
