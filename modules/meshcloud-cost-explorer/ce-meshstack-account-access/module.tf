# meshstack Account Setup
resource "aws_iam_user" "meshcloud_cost_explorer" {
  name = var.meshstack_account_service_user_name
}

resource "aws_iam_access_key" "meshcloud_cost_explorer" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.meshcloud_cost_explorer.name
}

moved {
  from = aws_iam_access_key.meshcloud_cost_explorer
  to   = aws_iam_access_key.meshcloud_cost_explorer[0]
}

resource "aws_iam_policy" "meshcloud_cost_explorer_user" {
  name   = "${aws_iam_user.meshcloud_cost_explorer.name}AssumeRolePolicy"
  policy = data.aws_iam_policy_document.meshcloud_cost_explorer_user_assume_role.json
}

resource "aws_iam_user_policy_attachment" "meshcloud_cost_explorer" {
  user       = aws_iam_user.meshcloud_cost_explorer.name
  policy_arn = aws_iam_policy.meshcloud_cost_explorer_user.arn
}
#
# role which can be assumed by federated workload
resource "aws_iam_role" "assume_cost_explorer_role" {
  count = var.workload_identity_federation == null ? 0 : 1

  name               = "${aws_iam_user.meshcloud_cost_explorer.name}IdentityFederation"
  assume_role_policy = data.aws_iam_policy_document.workload_identity_federation[0].json
}

# attach permissions to assumed role
resource "aws_iam_role_policy_attachment" "meshfed_service" {
  count = var.workload_identity_federation == null ? 0 : 1

  role       = aws_iam_role.assume_cost_explorer_role[0].name
  policy_arn = aws_iam_policy.meshcloud_cost_explorer_user.arn
}
