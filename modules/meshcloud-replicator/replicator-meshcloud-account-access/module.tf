# meshcloud Account Setup
resource "aws_iam_user" "meshfed_service" {
  name = var.meshcloud_account_service_user_name
}

resource "aws_iam_access_key" "meshfed_service" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.meshfed_service.name
}

moved {
  from = aws_iam_access_key.meshfed_service
  to   = aws_iam_access_key.meshfed_service[0]
}

resource "aws_iam_policy" "meshfed_service_user" {
  name   = "${aws_iam_user.meshfed_service.name}AssumeRolePolicy"
  policy = data.aws_iam_policy_document.meshfed_service_user_assume_role.json
}

resource "aws_iam_user_policy_attachment" "meshfed_service" {
  user       = aws_iam_user.meshfed_service.name
  policy_arn = aws_iam_policy.meshfed_service_user.arn
}

# role which can be assumed by federated workload
resource "aws_iam_role" "assume_meshfed_service_role" {
  count = var.workload_identity_federation == null ? 0 : 1

  name               = "${aws_iam_user.meshfed_service.name}IdentityFederation"
  assume_role_policy = data.aws_iam_policy_document.workload_identity_federation[0].json
}

# attach permissions to assumed role
resource "aws_iam_role_policy_attachment" "meshfed_service" {
  count = var.workload_identity_federation == null ? 0 : 1

  role       = aws_iam_role.assume_meshfed_service_role[0].name
  policy_arn = aws_iam_policy.meshfed_service_user.arn
}
