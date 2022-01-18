# meshCloud Account Setup

resource "aws_iam_user" "meshfed_service" {
  name = var.meshcloud_account_service_user_name
}

resource "aws_iam_access_key" "meshfed_service" {
  user = aws_iam_user.meshfed_service.name
}

resource "aws_iam_policy" "meshfed_service_user" {
  name   = "${aws_iam_user.meshfed_service.name}AssumeRolePolicy"
  policy = data.aws_iam_policy_document.meshfed_service_user_assume_role.json
}

resource "aws_iam_user_policy_attachment" "meshfed_service" {
  user       = aws_iam_user.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service_user.arn
}
