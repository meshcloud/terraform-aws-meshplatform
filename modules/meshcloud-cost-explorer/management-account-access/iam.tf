# AWS Root Account Setup

resource "aws_iam_role" "cost_explorer_service" {
  name               = var.management_account_service_role_name
  description        = "This role is used by ${var.meshcloud_account_service_user_name} to obtain permissions on an org-wide level"
  assume_role_policy = data.aws_iam_policy_document.cost_explorer_service_assume_role.json
}

resource "aws_iam_policy" "cost_explorer_service" {
  name   = "${var.management_account_service_role_name}Policy"
  policy = data.aws_iam_policy_document.cost_explorer_service.json
}

resource "aws_iam_role_policy_attachment" "cost_explorer_service" {
  role       = aws_iam_role.cost_explorer_service.name
  policy_arn = aws_iam_policy.cost_explorer_service.arn
}
