# meshcloud Account Setup
resource "aws_iam_user" "meshcloud_cost_explorer" {
  name = var.meshcloud_account_service_user_name
}

resource "aws_iam_access_key" "meshcloud_cost_explorer" {
  user = aws_iam_user.meshcloud_cost_explorer.name
}

resource "aws_iam_policy" "meshcloud_cost_explorer_user" {
  name   = "${aws_iam_user.meshcloud_cost_explorer.name}AssumeRolePolicy"
  policy = data.aws_iam_policy_document.meshcloud_cost_explorer_user_assume_role.json
}

resource "aws_iam_user_policy_attachment" "meshcloud_cost_explorer" {
  user       = aws_iam_user.meshcloud_cost_explorer.name
  policy_arn = aws_iam_policy.meshcloud_cost_explorer_user.arn
}
